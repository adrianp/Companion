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
	(action-pattern (preconditions dp-1) (effects dp-0) (type deplasare))
	
	(description-pattern (ID dp-2) (type pozitie) (parameters biblioteca))
	(description-pattern (ID dp-3) (type pregatire) (parameters facultate curs))
	(action-pattern (preconditions dp-2) (effects dp-3) (type studiu))
	
	(description-pattern (ID dp-4) (type pozitie) (parameters sala_experimente))
	(description-pattern (ID dp-5) (type pregatire) (parameters facultate laborator))
	(action-pattern (preconditions dp-4) (effects dp-5) (type studiu))
)

(deffacts auxiliare
	(reset gen)
)
