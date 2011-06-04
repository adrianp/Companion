(deftemplate Description
	(multislot ID)
	(multislot type)
	(multislot parameters)
)


(deftemplate ACTION
	(multislot ID)
	(multislot preconditions)
	(multislot effects)
	(multislot type)
)

(deftemplate description-pattern
	(multislot ID)
	(multislot type)
	(multislot parameters)
)

(deftemplate action-pattern
	(multislot preconditions)
	(multislot effects)
	(multislot type)
)

(deftemplate CAUSAL-LINK
	(multislot before)
	(multislot after)
	(multislot precondition)
)

(deftemplate ORDER-LINK
	(multislot left)
	(multislot right)
)

(deftemplate flaws
	(multislot threat)
	(multislot links)
)

(deftemplate chain
	(multislot threat)
	(multislot links)
)

(deffacts initial
	(Description (ID D-0) (type pozitie) (parameters acasa))
	(Description (ID D-1) (type pozitie) (parameters facultate))
	(Description (ID D-2) (type pregatire) (parameters curs))
	(ACTION (ID A-0) (effects D-0))
	(ACTION (ID A-N) (preconditions D-1 D-2))
)

(deffacts actiuni-posibile
	(description-pattern (ID dp-0) (type pozitie) (parameters))
	(description-pattern (ID dp-1) (type pozitie) (parameters))
	(action-pattern (preconditions dp-1) (effects dp-0) (type deplasare))
	
	(description-pattern (ID dp-2) (type pozitie) (parameters biblioteca))
	(description-pattern (ID dp-3) (type pregatire) (parameters))
	(action-pattern (preconditions dp-2) (effects dp-3) (type studiu))
)

(defrule R0_1
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
	(assert (ACTION (ID ?s) (type $?v) (preconditions ) (effects ?w)))
	(assert (CAUSAL-LINK (before ?s) (after ?t) (precondition ?x)))
	(assert (ORDER-LINK (left ?s) (right ?t)))
	(assert (ORDER-LINK (left A-0) (right ?s)))
	(assert (ORDER-LINK (left ?s) (right A-N)))
)

(defrule R0_2
	(ACTION (ID $?t) (preconditions $? ?x $?))
	(Description (ID ?x) (type $?y) (parameters $?z))
	(not (CAUSAL-LINK (after $?t) (precondition ?x)))
	(action-pattern (effects $?u) (preconditions $?u1) (type $?v))
	(description-pattern (ID $?u) (type $?y))
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

(defrule R1
	(declare (salience 400))
	?a<-(ACTION (ID $?x) (preconditions ) (effects $?y) (type $?z))
	(action-pattern (preconditions $?t) (type $?z))
	(description-pattern (type $?s))
	(ACTION (ID $?w) (effects $?u))
	(Description (ID $?u) (type $?s) (parameters $?v))
	(ORDER-LINK (left $?w) (right $?x))
	=>
	(bind ?r (str-cat "D-"(gensym)))
	(assert (Description (ID ?r) (type $?s) (parameters $?v)))
	(modify ?a (preconditions ?r))
	(assert (CAUSAL-LINK (before ?w) (after ?x) (precondition ?r)))
)

(defrule R2
	(declare (salience 300))
	(ACTION (ID $?x) (effects $?y))
	(test (not (subset (mv-append A-0) $?x)))
	(Description (ID $?y) (type $?z) (parameters $?t))
	(CAUSAL-LINK (before $?w&~$?x) (after $?v&~$?x) (precondition $?u))
	(Description (ID $?u) (type $?z) (parameters ~$?t))
	(not (flaws (threat $?x)))
	=>
	(assert (flaws (threat $?x) (links $?w $?v)))
)

(defrule R3
	(declare (salience 300))
	(ACTION (ID $?x) (effects $?y))
	(test (not (subset (mv-append A-0) $?x)))
	(Description (ID $?y) (type $?z) (parameters $?t))
	(CAUSAL-LINK (before $?w&~$?x) (after $?v&~$?x) (precondition $?u))
	(Description (ID $?u) (type $?z) (parameters ~$?t))
	?a<-(flaws (threat $?x) (links $?s))
	(not (flaws (threat $?x) (links $? $?w $?v $?)))
	=>
	(retract ?a)
	(assert (flaws (threat $?x) (links $?s $?w $?v)))
)

(defrule R4
	(declare (salience 200))
	?a<-(flaws (threat $?x) (links $?y))
	=>
	(assert (chain (threat $?x) (links $?y)))
)
	
(defrule R5
	(declare (salience 100))
	?a<-(chain (threat $?x) (links $?y ?f ?f $?z))
	=>
	(retract ?a)
	(assert (chain (threat $?x) (links ?y ?z)))
)
	
(defrule R6_0
	?a<-(chain (threat $?x) (links ?y ?z))
	(test (not (eq A-N ?z)))
	(ACTION (ID $?x) (preconditions $?w))
	(ACTION (ID ?z) (preconditions $?v))
	(Description (ID $?v) (type $?s) (parameters ?h))
	?b<-(Description (ID $?w) (type $?s))
	?c<-(CAUSAL-LINK (after $?x))
	?d<-(ORDER-LINK (right $?x))
	=>
	(retract ?a)
	(modify ?b (parameters ?h))
	(modify ?c (before ?z))
	(modify ?d (left ?z))
)
	
(defrule R6_1
	?a<-(chain (threat $?x) (links ?y ?z))
	(test (not (eq A-0 ?y)))
	(ACTION (ID $?x) (preconditions $?w))
	(ACTION (ID ?y) (preconditions $?v))
	(Description (ID $?v) (type $?s) (parameters ?h))
	?b<-(Description (ID $?w) (type $?s))
	?c<-(CAUSAL-LINK (after $?x))
	?d<-(ORDER-LINK (right $?x))
	=>
	(retract ?a)
	(modify ?b (parameters ?h))
	(modify ?c (after ?y))
	(modify ?d (right ?z))
)
