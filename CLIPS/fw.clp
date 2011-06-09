(deffacts f
	(matrice m1 3 0 8 9 -8 0 2 -9 -2 0)
	(matrice m2 3 0 8 9 -8 0 1 -9 -1 0)
	(matrice m3 5 0 2 i i 7 -1 0 4 i i i -3 0 -1 i i i 2 0 5 -6 i i -4 0)
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
	(assert (rezultat ?id ?n $?elem))
)

(deffunction checkConsistency (?id ?n $?elem)
	(loop-for-count (?i 1 ?n) do
		(loop-for-count (?j 1 ?n) do
			(if (= ?i ?j)
				then
					(if (> 0 (nth (+ ?j (* ?n (- ?i 1))) $?elem))
						then
						(assert (incosistenta ?id))
						(break)
					)
			)
		)
	)
)


(defrule R0
	(matrice ?id ?n $?elem)
	=>
	(fw ?id ?n $?elem)
)

(defrule R1
	?a<-(rezultat ?id ?n $?elem)
	=>
	(retract ?a)
	(checkConsistency ?id ?n $?elem)
)
