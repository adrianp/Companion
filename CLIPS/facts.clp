;starile initiale si finale ale planului impreuna cu efectele respectiv preconditiile
(deffacts initial
	(Description (ID D-0) (type pozitie) (parameters home))
	(Description (ID D-1) (type pozitie) (parameters university))
	(Description (ID D-2) (type preparation) (parameters didactic lecture))
	(Description (ID D-3) (type preparation) (parameters didactic laboratory))
	(ACTION (ID A-0) (effects D-0))
	(ACTION (ID A-N) (preconditions D-1 D-2 D-3))
)

;activitatile posibile pe care le poate intreprinde Masterul
(deffacts actiuni-posibile
	(description-pattern (ID dp-0) (type pozitie) (parameters))
	(description-pattern (ID dp-1) (type pozitie) (parameters))
	(action-pattern (ID ap-0)(preconditions dp-1) (effects dp-0) (type travelling))
	
	(description-pattern (ID dp-2) (type pozitie) (parameters library))
	(description-pattern (ID dp-3) (type preparation) (parameters didactic lecture))
	(action-pattern (ID ap-1) (preconditions dp-2) (effects dp-3) (type study) (duration 2))
	
	(description-pattern (ID dp-4) (type pozitie) (parameters laboratory))
	(description-pattern (ID dp-5) (type preparation) (parameters didactic laboratory))
	(action-pattern (ID ap-2)(preconditions dp-4) (effects dp-5) (type study) (duration 1))
)

;specificare momentelor la care Masterul isi incepe repsectiv termina activitatea
(deffacts timpi
	(explicit-time (firstA A-0) (secondA "A-gen11") (duration 7))
	(explicit-time (firstA A-0) (secondA A-N) (duration 14))	
)

;duratele diverselor tipuri de deplasari
(deffacts duratedepl
	(duration-travelling (initial home) (final library) (duration 0.5))
	(duration-travelling (initial library) (final laboratory) (duration 2))
	(duration-travelling (initial laboratory) (final university) (duration 1.5))
)

;alte fapte auxiliare folosite de algoritmul de planificare (rol intern)
(deffacts aux
	(reset gen)
	(graf)
)
