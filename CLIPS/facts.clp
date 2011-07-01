;starile initiale si finale ale planului impreuna cu efectele respectiv preconditiile
(deffacts initial
	(Description (ID D-0) (type pozitie) (parameters home))
	(Description (ID D-1) (type pozitie) (parameters university))
	(Description (ID D-2) (type preparation) (parameters didactic lecture))
	(Description (ID D-3) (type preparation) (parameters didactic laboratory))
	(Description (ID D-4) (type shopping) (parameters book))
	(Description (ID D-5) (type meeting) (parameters friend))
	(ACTION (ID A-0) (effects D-0))
	(ACTION (ID A-N) (preconditions D-1 D-2 D-3 D-4))
)

;activitatile posibile pe care le poate intreprinde Masterul
(deffacts actiuni-posibile
	(description-pattern (ID dp-0) (type pozitie) (parameters))
	(description-pattern (ID dp-1) (type pozitie) (parameters))
	(action-pattern (ID ap-0)(preconditions dp-1) (effects dp-0) (type travelling))

	(description-pattern (ID dp-2) (type pozitie) (parameters library))
	(description-pattern (ID dp-3) (type preparation) (parameters didactic lecture))
	(action-pattern (ID ap-1) (preconditions dp-2) (effects dp-3) (type study) (duration 1.5))

	(description-pattern (ID dp-4) (type pozitie) (parameters laboratory))
	(description-pattern (ID dp-5) (type preparation) (parameters didactic laboratory))
	(action-pattern (ID ap-2)(preconditions dp-4) (effects dp-5) (type study) (duration 1))

	(description-pattern (ID dp-6) (type pozitie) (parameters book-shop))
	(description-pattern (ID dp-7) (type shopping) (parameters book))
	(action-pattern (ID ap-3)(preconditions dp-6) (effects dp-7) (type misc) (duration 0.1))

	(description-pattern (ID dp-8) (type pozitie) (parameters park))
	(description-pattern (ID dp-9) (type meeting) (parameters friend))
	(action-pattern (ID ap-4)(preconditions dp-8) (effects dp-9) (type social) (duration 0.5))
)

;specificare momentelor la care Masterul isi incepe repsectiv termina activitatea
(deffacts timpi
	(explicit-time (firstA A-0) (secondA) (duration 7))
	(explicit-time (firstA A-0) (secondA A-N) (duration 14))
)

;duratele diverselor tipuri de deplasari
(deffacts duratedepl
	(duration-travelling (initial home) (final library) (duration 0.5))
	(duration-travelling (initial library) (final laboratory) (duration 1))
	(duration-travelling (initial laboratory) (final university) (duration 0.8))
	(duration-travelling (initial home) (final university) (duration 2))
	(duration-travelling (initial home) (final laboratory) (duration 0.6))
	(duration-travelling (initial library) (final university) (duration 0.9))
	(duration-travelling (initial home) (final book-shop) (duration 1))
	(duration-travelling (initial library) (final book-shop) (duration 0.7))
	(duration-travelling (initial laboratory) (final book-shop) (duration 0.5))
	(duration-travelling (initial book-shop) (final university) (duration 1))
	(duration-travelling (initial book-shop) (final library) (duration 0.7))
	(duration-travelling (initial book-shop) (final laboratory) (duration 0.5))
	(duration-travelling (initial laboratory) (final library) (duration 0.5))
	(duration-travelling (initial park) (final laboratory) (duration 1))
	(duration-travelling (initial park) (final library) (duration 0.2))
	(duration-travelling (initial park) (final book-shop) (duration 0.3))
	(duration-travelling (initial park) (final university) (duration 1.5))
	(duration-travelling (initial home) (final park) (duration 0.4))
	(duration-travelling (initial library) (final park) (duration 0.2))
	(duration-travelling (initial laboratory) (final park) (duration 1))
	(duration-travelling (initial book-shop) (final park) (duration 0.3))

)

;alte fapte auxiliare folosite de algoritmul de planificare (rol intern)
(deffacts aux
	(reset gen)
	(graf)
)

