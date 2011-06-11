;descriere preconditii/efecte
(deftemplate Description
	(multislot ID)
	(multislot type)
	(multislot parameters)
)

;activitate
(deftemplate ACTION
	(multislot ID)
	(multislot preconditions)
	(multislot effects)
	(multislot type)
	(multislot duration (type NUMBER))
)

;model descriere preconditii/efecte
(deftemplate description-pattern
	(multislot ID)
	(multislot type)
	(multislot parameters)
)

;model activitate
(deftemplate action-pattern
	(multislot ID)
	(multislot preconditions)
	(multislot effects)
	(multislot type)
	(multislot duration (type NUMBER))
)

;legatura cauzala intre activitati
(deftemplate CAUSAL-LINK
	(multislot before)
	(multislot after)
	(multislot precondition)
)

;relatie de ordine intre activitati
(deftemplate ORDER-LINK
	(multislot left)
	(multislot right)
)

;defecte ale planului; pentru fiecare activitate se mentioneaza legaturile cauzale
;puse in pericol de catre efectele acesteia
(deftemplate flaws
	(multislot threat)
	(multislot links)
)

;lant de activitati
(deftemplate chain
	(multislot threat)
	(multislot links)
)

;cu ajutorul acestui template se pot defini explicit anumite distante temporale
;(de exemplu intre starea initiala si cea finala) 
(deftemplate explicit-time
	(multislot firstA)
	(multislot secondA)
	(multislot duration (type NUMBER))
)

;cu ajutorul acestui template se pot defini duratele pentru actiunile de deplasare
(deftemplate duration-travelling
	(multislot initial)
	(multislot final)
	(multislot duration (type NUMBER))
)

;elementele matricii folosite in algoritmul Floyd-Warshall
(deftemplate elem
	(slot index)
	(multislot first)
	(multislot second)
	(multislot duration)
)
