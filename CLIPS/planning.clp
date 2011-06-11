;FUNCTII
(deffunction minus ($?d)
	(loop-for-count (?i 1 (length $?d)) do
		(bind $?d (replace$ $?d ?i ?i (- 0 (nth ?i $?d))))
	)
	(return $?d)
)

(deffunction fw (?id ?n $?elem)
	(loop-for-count (?k 1 ?n) do
		(loop-for-count (?i 1 ?n) do
			(loop-for-count (?j 1 ?n) do
				(bind ?p (+ ?j (* ?n (- ?i 1))))
				(bind ?ij (nth ?p $?elem))
				(bind ?ik (nth (+ ?k (* ?n (- ?i 1))) $?elem))
				(bind ?kj (nth (+ ?j (* ?n (- ?k 1))) $?elem))
				(if (numberp ?ij) 
					then
					(if (and (numberp ?ik) (numberp ?kj))
						then
						(if (> ?ij (+ ?ik ?kj))
							then
							(bind $?elem (replace$ $?elem ?p ?p (+ ?ik ?kj)))
						)
					)
					else
					(if (and (numberp ?ik) (numberp ?kj))
						then
						(bind $?elem (replace$ $?elem ?p ?p (+ ?ik ?kj)))
					)
				)
			)
		)
	)
	(assert (minimal-matrix ?id ?n $?elem))
	(return $?elem)
)

(deffunction checkConsistency (?id ?n $?elem)
	(loop-for-count (?i 1 ?n) do
		(loop-for-count (?j 1 ?n) do
			(if (= ?i ?j)
				then
					(if (> 0 (nth (+ ?j (* ?n (- ?i 1))) $?elem))
						then
						(assert (incosistenta ?id))
						(return)
					)
			)
		)
	)
	(assert (consistenta ?id))
)
;END FUNCTII

;REGULI
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
	(action-pattern (effects $?u) (preconditions $?u1)(type $?v) (durata $?dur))
	(description-pattern (ID $?u) (type $?y))
	(description-pattern (ID $?u1) (parameters))
	=>
	(bind ?w (str-cat "D-"(gensym)))
	(bind ?s (str-cat "A-"(gensym)))
	(assert (Description (ID ?w) (type ?y) (parameters ?z)))
	(assert (ACTION (ID ?s) (type $?v) (preconditions) (effects ?w) (durata $?dur)))
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
	(action-pattern (effects $?u) (preconditions $?u1) (type $?v) (durata $?dur))
	(description-pattern (ID $?u)  (type $?y) (parameters $?z))
	(description-pattern (ID $?u1) (type ?hhh) (parameters ?hh))
	=>
	(bind ?w (str-cat "D-"(gensym)))
	(bind ?s (str-cat "A-"(gensym)))
	(bind ?ww (str-cat "D-"(gensym)))
	(assert (Description (ID ?w) (type ?y) (parameters ?z)))
	(assert (Description (ID ?ww) (type ?hhh) (parameters ?hh)))
	(assert (ACTION (ID ?s) (type $?v) (preconditions ?ww) (effects ?w) (durata $?dur)))
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

;formarea lantului folosit in reprogramarea actiunii de catre regulile R9
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

;asignare timp deplasari
(defrule R10
	(declare (salience -100))
	?a<-(ACTION (preconditions $?x) (effects $?y) (type deplasare) (durata))
	(Description (ID $?x) (type pozitie) (parameters $?z))
	(Description (ID $?y) (type pozitie) (parameters $?t))
	(durata-deplasare (initial $?z) (final $?t) (durata $?v))
	=>
	(modify ?a (durata $?v))
)

;creare lant graf
(defrule R11_1
	(declare (salience -200))
	?a<-(graf $?y)
	(ACTION (ID $?x))
	(not (graf $? $?x $?))
	=>
	(retract ?a)
	(assert (graf $?x $?y))
)

;ordonare graf
(defrule R11_2
	(declare (salience -200))
	?a<-(graf $?v $?x $?b $?y $?w)
	(ORDER-LINK (left $?y) (right $?x))
	=>
	(retract ?a)
	(assert (graf $?v $?y $?b $?x $?w))
)	

;eliminare ordonari fata de A0 redundante
(defrule R12_1
	(declare (salience -300))
	(graf ? ?x $?)
	?a<-(ORDER-LINK (left A-0) (right $?y))
	(test (not (subset (mv-append ?x) $?y)))
	=>
	(retract ?a)
)

;eliminare ordonari fata de AN redundante
(defrule R12_2
	(declare (salience -300))
	(graf $? ?x ?)
	?a<-(ORDER-LINK (left $?y) (right A-N))
	(test (not (subset (mv-append ?x) $?y)))
	=>
	(retract ?a)
)

(defglobal ?*A* = 0)

;elem creare elemente matrice
(defrule R13
	(declare (salience -400))
	(ACTION (ID $?x))
	(graf $? ?y $?)
	=>
	(bind ?*A* (+ 1 ?*A*))
	(assert (elem (index ?*A*) (first $?x) (second $?y)))
)

;ordonare elemente matrice
(defrule R14_1
	?v<-(elem (index ?i1) (first $?a) (second $?x) (durata $?y))
	?w<-(elem (index ?i2) (first $?b) (second $?z) (durata $?t))
	(ORDER-LINK (left $?b) (right $?a))
	(test (> ?i2 ?i1))
	=>
	(retract ?v ?w)
	(assert (elem (index ?i2) (first $?a) (second $?x) (durata $?y)))
	(assert (elem (index ?i1) (first $?b) (second $?z) (durata $?t)))
)

;ordonare elemente matrice
(defrule R14_2
	?v<-(elem (index ?i1) (first $?a) (second $?x) (durata $?y))
	?w<-(elem (index ?i2) (first $?a) (second $?z) (durata $?t))
	(ORDER-LINK (left $?z) (right $?x))
	(test (> ?i2 ?i1))
	=>
	(retract ?v ?w)
	(assert (elem (index ?i2) (first $?a) (second $?x) (durata $?y)))
	(assert (elem (index ?i1) (first $?a) (second $?z) (durata $?t)))
)

;caz +
(defrule R15_1
	(graf $? ?x ?y $?)
	?a<-(elem (first ?x) (second ?y) (durata $?v))
	(test (eq $?v (mv-append)))
	(test (neq A-0 ?x))
	(ACTION (ID ?x) (durata $?z))
	=>
	(modify ?a (durata $?z))
)
	
;caz -
(defrule R15_2
	(graf $? ?x ?y $?)
	?a<-(elem (first ?y) (second ?x) (durata $?v))
	(test (eq $?v (mv-append)))
	(ACTION (ID ?x) (durata $?z))
	(test (neq A-0 ?x))
	=>
	(bind $?w (minus $?z))
	(modify ?a (durata $?w))
)

;caz explicit
(defrule R15_3
	(timp-explicit (firstA $?x) (secondA $?y) (durata $?z))
	?a<-(elem (first $?x) (second $?y) (durata $?v))
	?b<-(elem (first $?y) (second $?x) (durata $?w))
	(test (eq $?v (mv-append)))
	(test (eq $?w (mv-append)))
	=>
	(bind $?s (minus $?z))
	(modify ?a (durata $?z))
	(modify ?b (durata $?s))
)

;caz 0
(defrule R15_5
	?a<-(elem (first $?x) (second $?x) (durata $?v))
	(test (eq $?v (mv-append)))
	=>
	(modify ?a (durata 0))
)

;creare matrice initial
(defrule R16
	(declare (salience -300))
	(graf $?x)
	(not (matrix $?))
	=>
	(assert (matrix (gensym) (length $?x)))
)

;completare matrice
(defrule R17_1
	(declare (salience -500))
	?a<-(elem (index ?x) (durata ?y))
	(not (elem (index ?z&:(< ?z ?x))))
	?b<-(matrix ?id ?dim $?r)
	=>
	(retract ?a ?b)
	(assert (matrix ?id ?dim $?r ?y))
)

(defrule R17_2
	(declare (salience -500))
	?a<-(elem (index ?x) (durata $?y))
	(test (eq $?y (mv-append)))
	(not (elem (index ?z&:(< ?z ?x))))
	?b<-(matrix ?id ?dim $?r)
	=>
	(retract ?a ?b)
	(assert (matrix ?id ?dim $?r i))
)

(defrule R18
	(declare (salience -600))
	(matrix ?id ?n $?elem)
	=>
	(bind $?r (fw ?id ?n $?elem))
	(checkConsistency ?id ?n $?r)
)
;END REGULI
