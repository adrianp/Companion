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
	(multislot durata (type NUMBER))
)

(deftemplate description-pattern
	(multislot ID)
	(multislot type)
	(multislot parameters)
)

(deftemplate action-pattern
	(multislot ID)
	(multislot preconditions)
	(multislot effects)
	(multislot type)
	(multislot durata (type NUMBER))
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

;3 scopuri pregatire curs pentru facultate, pregatire laborator pentru facultate, sa fie la facultate in final
(deffacts initial
	(Description (ID D-0) (type pozitie) (parameters acasa))
	(Description (ID D-1) (type pozitie) (parameters facultate))
	(Description (ID D-2) (type pregatire) (parameters facultate curs))
	(Description (ID D-3) (type pregatire) (parameters facultate laborator))
	(ACTION (ID A-0) (effects D-0))
	(ACTION (ID A-N) (preconditions D-1 D-2 D-3))
)

(deffacts actiuni-posibile
	(description-pattern (ID dp-0) (type pozitie) (parameters))
	(description-pattern (ID dp-1) (type pozitie) (parameters))
	(action-pattern (ID ap-0)(preconditions dp-1) (effects dp-0) (type deplasare))
	
	(description-pattern (ID dp-2) (type pozitie) (parameters biblioteca))
	(description-pattern (ID dp-3) (type pregatire) (parameters facultate curs))
	(action-pattern (ID ap-1) (preconditions dp-2) (effects dp-3) (type studiu) (durata 2))
	
	(description-pattern (ID dp-4) (type pozitie) (parameters sala_experimente))
	(description-pattern (ID dp-5) (type pregatire) (parameters facultate laborator))
	(action-pattern (ID ap-2)(preconditions dp-4) (effects dp-5) (type studiu) (durata 1))
)

(deffacts auxiliare
	(reset gen)
	(graf)
)

(deftemplate durata-deplasare
	(multislot initial)
	(multislot final)
	(multislot durata (type NUMBER))
)

(deffacts duratedepl
	(durata-deplasare (initial acasa) (final biblioteca) (durata 0.5))
	(durata-deplasare (initial biblioteca) (final sala_experimente) (durata 2))
	(durata-deplasare (initial sala_experimente) (final facultate) (durata 1.5))
)

(deftemplate timp-explicit
	(multislot firstA)
	(multislot secondA)
	(multislot durata (type NUMBER))
)

(deftemplate linie
	(slot nod)
	(multislot vecini)
)

(deftemplate elem
	(slot index)
	(multislot first)
	(multislot second)
	(multislot durata)
)

(deffacts timpi
	(timp-explicit (firstA A-0) (secondA "A-gen11") (durata 7))
	(timp-explicit (firstA A-0) (secondA A-N) (durata 6))	
)
