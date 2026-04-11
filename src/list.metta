;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Type  definations of the list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(: Nil (List $t))
(: Cons (-> $t (List $t) (List $t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Length of any list type
(: length (-> (List $t) Number))
(= (length Nil) 0) 
(= (length (Cons $x $xs))
   (+ 1 (length $xs)))
   
;;membership
(: is-member (-> $t (List $t) Bool))

(= (is-member $x Nil) False)
(= (is-member $x (Cons $y $ys))
   (if (== $x $y) 
       True 
       (is-member $x $ys)))


;;appending list to anther list
(: append (-> (List $t) (List $t) (List $t)))

(= (append Nil $ys) $ys)
(= (append (Cons $x $xs) $ys)
(Cons $x (append $xs $ys)))
 
;;push/pop using front as top
(: push (-> $t (List $t) (List $t)))
(: pop (-> (List $t) ($t ((List $t)))))

(= (push $x $list)
   (Cons $x $list))

(= (pop Nil) Nil)

(= (pop (Cons $x $xs)) ($x $xs))


;;assumed with list has at leasin one element
(: max-value (-> (List Number) Number))

(= (max-value Nil) Nil)
(= (max-value (Cons $x Nil)) $x)
(= (max-value (Cons $x (Cons $y $ys))) 
(let $m (max-value (Cons $y $ys))
 (if (> $x $m) $x $m)))
 

;;assumed with list has at leasin one element
(: min-value (-> (List Number) Number))

(= (min-value Nil) Nil)
(= (min-value  (Cons $x Nil)) $x)
 (= (min-value (Cons $x (Cons $y $ys)))
 (let $min (min-value (Cons $y $ys))
   (if (< $x $min) $x $min)
))


;;;Remove all occurance of the element 
(: remove-element (-> $t (List $t) (List $t)))

(= (remove-element $x Nil) Nil)
(= (remove-element $x (Cons $y $ys))
   (if (== $x $y)  
   (remove-element $x $ys)
   (Cons $y (remove-element $x $ys))))


;;remove duplicates and make list set of unque elemnts
 
(= (remove-duplicate Nil) Nil)
(= (remove-duplicate (Cons $x $xs))
 (Cons $x (remove-duplicate 
 (remove-element $x $xs))))


;;map function to every element
(: map (-> (-> $a $a) (List $a) (List $a)))

(= (map $f Nil) Nil)
(= (map $f (Cons $x $xs))
    (Cons ($f $x) (map $f $xs)))
(= (square $x) (* $x $x))


;; filter: keep elements satisfying predicate
(: filter (-> (-> $a Bool) (List $a) (List $a)))

(= (filter $func Nil) Nil)
(= (filter $func (Cons $x $xs))
(if ($func $x) (Cons $x (filter $func $xs)) 
(filter $func $xs)))

(: is-positive (-> Number Bool))

(= (is-positive $x) (> $x 0))


;;reverse by appending each element to end from start


(= (reverse ()) ())
(= (reverse (Cons $x $xs))
   (append (reverse $xs) (Cons $x ())))


;; insert element into sorted list
(= (insert $x ()) (Cons $x ()))
(= (insert $x (Cons $y $ys))
   (if (<= $x $y)
       (Cons $x (Cons $y $ys))
       (Cons $y (insert $x $ys))))

;; sort using insertion sort
(: sort (-> (List Number) (List Number)))
(= (sort Nil) Nil)
(= (sort (Cons $x $xs))
   (insert $x (sort $xs)))
   
;;fold list from left to right
(: Folder (-> Number Number Number))
(: foldl (-> Folder Number (List Number) Number))

(= (foldl $f $a ()) $a)
(= (foldl $f $a (Cons $x $xs))
(foldl $f ($f $a $x) $xs)
)

;;foldl helper
(= (product $y $z) (* $z $y))


;;;;; forl list from right to left
 (: foldr (-> Folder Number (List Number) Number))

(= (foldr $f $a Nil) $a)
(= (foldr $f $a (Cons $x $xs))
   ($f $x (foldr $f $a $xs))
)

;;foldr helper function
(= (sum $z $y) (+ $z $y))
;;sum list 
(= (sum-list Nil) 0)
(= (sum-list (Cons $x $xs))
      (+ $x (sum-list $xs)))


;product
(= (product Nil) 1)
(= (product (Cons $x $xs))
(* $x (product $xs))
)


;;;;
 (: until (-> (-> $a Bool) (-> $a $a) $a $a))
(= (until $p $f $x )
(if ($p $x)
     $x
     (until $p $f ($f $x))
     ))
(= (less-than-one $x)
  (<= $x 1) )

;;;;;;;


;;compose  simplified
(= ((compose $f $g) $value)
   ($f ($g $value)))

;;compose function arguments example

(= (cube $x) (* $x (* $x $x)))
(= (half $x) (/ $x 2))
;;;

;;curry2 simplified

(= ((curry2 $f) $val1)
  (Partial $val1))
(= ((Partial  $f $val1) $val2)
    ($f $val1 $val2))

;;;;;;
;three argument curry simplified

(= ((curry $f) $val1)
   (Partial3a $f val1))
   
(= ((Partial3a $f $val1) $val2)
    (Partial3b $f $val1 $val2))

(= ((Partial3b $f $val1 $val2) $val3) 
   ($f $val1 $val2 $val3))

;;curry helper that take 3 numbers and return max of them

(: help (-> Number Number Number Number))
(= (help $x $y $z)
   (max-value (Cons $x (Cons $y (Cons $z ())))))

;;count a memeber
(: count (-> $t (List $t) Number));;

(= (count $x ()) 0)
(= (count $n (Cons $x $xs))
   (if (== $n $x) (+ 1 (count $n $xs))
                (count $n $xs)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;tests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 

(= (list) (Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 (Cons -1 Nil)))))))
(= (list2) (Cons 10 (Cons 30 Nil)))
(= (names) (Cons "Abebe" (Cons "kalab" (Cons "Aster" (Cons "Sami" Nil)))))
;;
;;;type check;;
!(get-type (Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 (Cons -1 Nil)))))))

!(length (names))
!(is-member "Abebe" (names))
!(push 20 (list))
!(pop (list))
!(append (list2) (list))
!(max-value (list))
!(min-value (list))
!(remove-element 34 (list))
!(remove-duplicate (list))
!(filter is-positive (list))
!(map square (list))
;!(reverse (list))
!(foldl product 1 (list))
!(foldr sum 0 (Cons 2 (list)))
!(sort (list))
!(sum-list (list))
!(product (list))
!(until less-than-one half 100)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;results
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
[(List Number)]
; [4]
; [True]
; [(Cons 20 (Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 (Cons -1 Nil)))))))]
; [(11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 (Cons -1 Nil))))))]
; [(Cons 10 (Cons 30 (Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 (Cons -1 Nil))))))))]
; [54]
; [-1]
; [(Cons 11 (Cons 14 (Cons 54 (Cons 11 (Cons -1 Nil)))))]
; [(Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons -1 Nil)))))]
; [(Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 Nil)))))]
; [(Cons 121 (Cons 196 (Cons 2916 (Cons 1156 (Cons 121 (Cons 1 Nil))))))]
; [-3110184]
; [125]
; [(Cons -1 (Cons 11 (Cons 11 (Cons 14 (Cons 34 (Cons 54 Nil))))))]
; [1]
; [-3110184]
; [123]
; [500]
; [2]
; [60]
; [25]
















