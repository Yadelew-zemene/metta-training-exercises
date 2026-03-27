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

;;helper
(= (append () $ys) $ys)
(= (append (Cons $x $xs) $ys)
(Cons $x (append $xs $ys)))
;; inorder transeversal
(= (inorder leaf) ())
(= (inorder (Cons $value $left $right))
    (append (inorder $left)
            (Cons $value (inorder $right))
))

;;preorder tree traversal
(= (preorder leaf) ())
(= (preorder (Cons $value $left $right))
    (append (Cons $value (preorder $left))
            (preorder $right)
))
;; post order
(= (postorder leaf) ())
(= (postorder (Cons $value $left $right)) 
   (append 
         (append (postorder $left)
                 (postorder $right))
         (Cons $value ())        
        
    ))

!(get-root (binary-tree))
!(get-left  (binary-tree))
!(get-right (binary-tree))
!(size (binary-tree))
!(is-member 5  (binary-tree) )
!(inorder (binary-tree))
!(preorder (binary-tree))
!(postorder (binary-tree))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; results
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [6]
; [(Cons 5 (Cons 4 leaf leaf) (Cons 7 leaf leaf))]
; [(Cons 8 (Cons 14 leaf leaf) (Cons 17 leaf leaf))]
; [7]
; [True]
;[(Cons 4 (Cons 5 (Cons 7 (Cons 6 (Cons 14 (Cons 8 (Cons 17 ())))))))]
;[(Cons 6 (Cons 5 (Cons 4 (Cons 7 (Cons 8 (Cons 14 (Cons 17 ())))))))]
;[(Cons 4 (Cons 7 (Cons 5 (Cons 14 (Cons 17 (Cons 8 (Cons 6 ())))))))]















