;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;type & data defination of bynary tree
;;;;;;;;;;;;;;;;;;;;;;;;;;

(:Tree Type)
(:Btr Tree)
(:leaf Btr)
(:Cons (-> Number Btr Btr Btr));node construct

(= (binary-tree)
    (Cons 6
      (Cons 5
       (Cons 4 leaf leaf)
       (Cons 7 leaf leaf))
      (Cons 8
       (Cons 14 leaf leaf)
       (Cons 17 leaf leaf))
    ))
;;root value 
(= (get-root leaf) leaf)
(= (get-root (Cons $value $left $right)) $value)

;;left subtree
(= (get-left leaf) leaf)
(= (get-left (Cons $value $left $right)) $left)

;;right subtree
(= (get-right leaf) leaf)
(= (get-right (Cons $value $left $right))  $right )

;size of tree

(= (size leaf) 0)
(= (size (Cons $value $left $right))
   (+ 1 (+ (size $left) (size $right)) ))
 
;;search value
(= (is-member $x leaf) False)
(= (is-member $x (Cons $v $l $r))
   (if (== $x $v)
       True
       (or (is-member $x $l)
           (is-member $x $r))))

!(get-root (binary-tree))
!(get-left  (binary-tree))
!(get-right (binary-tree))
!(size (binary-tree))
!(is-member 5  (binary-tree) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; results
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [6]
; [(Cons 5 (Cons 4 leaf leaf) (Cons 7 leaf leaf))]
; [(Cons 8 (Cons 14 leaf leaf) (Cons 17 leaf leaf))]
; [7]
; [True]















