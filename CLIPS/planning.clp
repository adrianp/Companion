(defrule R0
	?a<-(reset gen)
	=>
	(retract ?a)
	(setgen 1)
)

;cautarea unui scop neindeplinit fara parametri in preconditii
(defrule R1_1
	(ACTION (ID $?t) (preconditions $? ?x $?))
	(Description (ID ?x) (type $?y) (parameters $?z))
	(not (CAUSAL-LINK (after $?t) (precondition ?x)))
	(action-pattern (effects $?u) (preconditions $?u1)(type $?v))
	(description-pattern (ID $?u) (type $?y))
	(description-pattern (ID $?u1) (parameters))
	=>
	(bind ?w (str-cat "D-"(gensym)))
	(bind ?s (str-cat "A-"(gensym)))
	(assert (Description (ID ?w) (type ?y) (parameters ?z)))
	(assert (ACTION (ID ?s) (type $?v) (preconditions) (effects ?w)))
	(assert (CAUSAL-LINK (before ?s) (after ?t) (precondition ?x)))
	(assert (ORDER-LINK (left ?s) (right ?t)))
	(assert (ORDER-LINK (left A-0) (right ?s)))
	(assert (ORDER-LINK (left ?s) (right A-N)))
)

;cautarea unui scop neindeplinit cu parametri in preconditii
(defrule R1_2
	(ACTION (ID $?t) (preconditions $? ?x $?))
	(Description (ID ?x) (type $?y) (parameters $?z))
	(not (CAUSAL-LINK (after $?t) (precondition ?x)))
	(action-pattern (effects $?u) (preconditions $?u1) (type $?v))
	(description-pattern (ID $?u)  (type $?y) (parameters $?z))
	(description-pattern (ID $?u1) (type ?hhh) (parameters ?hh))
	=>
	(bind ?w (str-cat "D-"(gensym)))
	(bind ?s (str-cat "A-"(gensym)))
	(bind ?ww (str-cat "D-"(gensym)))
	(assert (Description (ID ?w) (type ?y) (parameters ?z)))
	(assert (Description (ID ?ww) (type ?hhh) (parameters ?hh)))
	(assert (ACTION (ID ?s) (type $?v) (preconditions ?ww) (effects ?w)))
	(assert (CAUSAL-LINK (before ?s) (after ?t) (precondition ?x)))
	(assert (ORDER-LINK (left ?s) (right ?t)))
	(assert (ORDER-LINK (left A-0) (right ?s)))
	(assert (ORDER-LINK (left ?s) (right A-N)))
)

;actiunile cu preconditii vide sunt completate
(defrule R2
	(declare (salience 700))
	?a<-(ACTION (ID $?x) (preconditions) (effects $?y) (type $?z))
	(action-pattern (preconditions $?t) (type $?z))
	(description-pattern (type $?s))
	(ACTION (ID $?w) (effects $?u))
	(Description (ID $?u) (type $?s) (parameters $?v))
	(ORDER-LINK (left $?w) (right $?x))
	(not (stop $?x))
	=>
	(bind ?r (str-cat "D-"(gensym)))
	(assert (Description (ID ?r) (type $?s) (parameters $?v)))
	(modify ?a (preconditions ?r))
	(assert (CAUSAL-LINK (before ?w) (after ?x) (precondition ?r)))
)

;cautare conflicte (actiune care prin efectele sale pun in pericol o legatura cauzala)
(defrule R3_1
	(declare (salience 600))
	(ACTION (ID $?x) (effects $?y))
	(test (not (subset (mv-append A-0) $?x)))
	(Description (ID $?y) (type $?z) (parameters $?t))
	(CAUSAL-LINK (before $?w&~$?x) (after $?v&~$?x) (precondition $?u))
	(Description (ID $?u) (type $?z) (parameters $?k&:(neq (nth 1 $?k) (nth 1 $?t))))
	(not (flaws (threat $?x)))
	(not (stop $?x))
	=>
	(assert (flaws (threat $?x) (links $?w $?v)))
)

(defrule R3_2
	(declare (salience 500))
	(ACTION (ID $?x) (effects $?y))
	(test (not (subset (mv-append A-0) $?x)))
	(Description (ID $?y) (type $?z) (parameters $?t))
	(CAUSAL-LINK (before $?w&~$?x) (after $?v&~$?x) (precondition $?u))
	(Description (ID $?u) (type $?z) (parameters $?k&:(neq (nth 1 $?k) (nth 1 $?t))))
	?a<-(flaws (threat $?x) (links $?s))
	(not (flaws (threat $?x) (links $? $?w $?v $?)))
	(not (stop $?x))
	=>
	(retract ?a)
	(assert (flaws (threat $?x) (links $?s $?w $?v)))
)

;copiere conflicte in fapt special pentru descriere lanturi
(defrule R4
	(declare (salience 300))
	?a<-(flaws (threat $?x) (links $?y))
	(not (stop $?x))
	=>
	(assert (chain (threat $?x) (links $?y)))
)

; daca exista 2 atacuri reciproce, se pastreaza doar unul 
(defrule R5
	(declare (salience 500))
	?a<-(flaws (threat $?x) (links $? $?y  $?))
	(flaws (threat $?y) (links $? $?x  $?))
	=>
	(retract ?a) (assert (stop ?x))
)

;eliminare actiuni redundate din lant
(defrule R6
	(declare (salience 100))
	?a<-(chain (threat $?x) (links $?y ?f ?f $?z))
	=>
	(retract ?a)
	(assert (chain (threat $?x) (links ?y ?z)))
)

;aranjarea actiunilor dintr-un lant in functie de legaturile de ordine
(defrule R7
	(declare (salience 400))
	?a<-(flaws (threat $?z) (links $?v ?x $?t ?y $?w))
	(ORDER-LINK (left ?y) (right ?x))
	=>
	(assert (stop ?z))
	(modify ?a (links $?v ?y $?t ?x $?w))
)

;formarea lantului folosit in reprogramarea actiunii de catre regula R6(?)
(defrule R8
	(declare (salience 200))
	(flaws (threat $?z) (links $?a))
	=>
	(assert (chain (threat $?z) (links $?a)))
)

;rezolvare conflict prin reprogramare "dupa"
(defrule R9_1
	?a<-(chain (threat $?x) (links ?y ?z))
	(test (not (eq A-N ?z)))
	(ACTION (ID $?x) (preconditions $?w))
	(ACTION (ID ?z) (preconditions $?v))
	(Description (ID $?v) (type $?s) (parameters ?h))
	?b<- (Description (ID $?w) (type $?s))
	?c <- (CAUSAL-LINK (after $?x))
	?d<- (ORDER-LINK (right $?x))
	=>
	(retract ?a)
	(modify ?b (parameters ?h))
	(modify ?c (before ?z))
	(modify ?d (left ?z))
)

;rezolvare conflict prin reprogramare "inainte"
(defrule R9_2
	?a<-(chain (threat $?x) (links ?y ?z))
	(test (not (eq A-0 ?y)))
	(ACTION (ID $?x) (preconditions $?w))
	(ACTION (ID ?y) (preconditions $?v))
	(Description (ID $?v) (type $?s) (parameters ?h))
	?b<- (Description (ID $?w) (type $?s))
	?c <- (CAUSAL-LINK (after $?x))
	?d<- (ORDER-LINK (right $?x))
	=>
	(retract ?a)
	(modify ?b (parameters ?h))
	(modify ?c (after ?y))
	(modify ?d (right ?z))
)
