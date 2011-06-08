(deffacts f
	(matrice m1 3 0 8 9 -8 0 2 -9 -2 0)
	(matrice m2 3 0 8 9 -8 0 1 -9 -1 0)
)

(deffunction fw (?n $?elem)
	(loop-for-count (?k 1 ?n) do
		(loop-for-count (?i 1 ?n) do
			(loop-for-count (?j 1 ?n) do
				(bind ?ij (nth (+ ?j (* 3 (- ?i 1))) $?elem))
				(bind ?ik (nth (+ ?k (* 3 (- ?i 1))) $?elem))
				(bind ?kj (nth (+ ?j (* 3 (- ?k 1))) $?elem))
				(if (numberp ?ij) 
					then
					(if (and (numberp ?ik) (numberp ?kj))
						then
						(if (> ?ij (+ ?ik ?kj))
							then
								(bind $?elem (replace$ $?elem (+ ?j (* 3 (- ?i 1))) (+ ?j (* 3 (- ?i 1))) (+ ?ik ?kj)))
						)
					)
				) 
			)
		)
	)
	(assert (rezultat ?n $?elem))
)

(deffunction checkConsistency (?n $?elem)
	(loop-for-count (?i 1 ?n) do
		(loop-for-count (?j 1 ?n) do
			(if (= ?i ?j)
				then
					(if (> 0 (nth (+ ?j (* 3 (- ?i 1))) $?elem))
						then
						(assert (incosistenta))
						(break)
					)
			)
		)
	)
)


(defrule R0
	(matrice m1 ?n $?elem)
	=>
	(fw ?n $?elem)
)

(defrule R1
	(rezultat ?n $?elem)
	=>
	(checkConsistency ?n $?elem)
)
