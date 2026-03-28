;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Type ana data definations of the list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(: List Type)
(: Cons (-> Number List List))

(= (list) (Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 (Cons -1 ())))))))
(=(list2) (Cons 10 (Cons 30 ())))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Length
(= (length ()) 0) 
(= (length (Cons $x $xs))
   (+ 1 (length $xs)))
   
;;membership
(= (is-member $x ()) False)
(= (is-member $x (Cons $y $ys))
   (if (== $x $y) True (is-member $x $ys)))


;;appending list to anther list
(= (append () $ys) $ys)
(= (append (Cons $x $xs) $ys)
(Cons $x (append $xs $ys)))
 
;;push/pop using front as top

(= (push $x $list)
   (Cons $x $list))
(=(pop ()) ())
(=(pop (Cons $x $xs)) ($x $xs))


;;assumed with list has at leasin one element
(= (max-value ()) ())
(= (max-value (Cons $x ())) $x)
(= (max-value (Cons $x (Cons $y $ys))) 
(let $m (max-value (Cons $y $ys))
 (if (> $x $m) $x $m)))
 

;;assumed with list has at leasin one element
(= (min-value ()) ())
(= (min-value  (Cons $x ())) $x)
 (= (min-value (Cons $x (Cons $y $ys)))
 (let $min (min-value (Cons $y $ys))
   (if (< $x $min) $x $min)
))


;;;Remove all occurance of the element 
(: remove-element (-> Number List List))

(= (remove-element $x ()) ())
(= (remove-element $x (Cons $y $ys))
   (if (== $x $y)  
   (remove-element $x $ys)
   (Cons $y (remove-element $x $ys))))


;;remove duplicates and make list set of unque elemnts
(: remove-duplicate (-> List List))

(= (remove-duplicate ()) ())
(= (remove-duplicate (Cons $x $xs))
 (Cons $x (remove-duplicate 
 (remove-element $x $xs))))


;;map function to every element
(: func (-> Number Number))
(: map (-> func  List List))

(= (map $f ()) ())
(= (map $f (Cons $x $xs))
    (Cons ($f $x) (map $f $xs)))
(= (square $x) (* $x $x))


;; filter: keep elements satisfying predicate
(: Filt (-> Number Bool))
(: filter (-> Filt List List))

(= (filter $func ()) ())
(= (filter $func (Cons $x $xs))
(if ($func $x) (Cons $x (filter $func $xs)) 
(filter $func $xs)))

(= (is-positive $x) (if (> $x 0) True False))


;;reverse by appending each element to end from start
(: reverse (-> List List))

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
(= (sort ()) ())
(= (sort (Cons $x $xs))
   (insert $x (sort $xs)))
   
;;fold list from left to right
(: Folder (-> Number Number Number) )
(: foldl (-> Folder Number List Number))

(= (foldl $f $a ()) $a)
(= (foldl $f $a (Cons $x $xs))
(foldl $f ($f $a $x) $xs)
)

;;foldl helper
(= (product $y $z) (* $z $y))


;;;;; forl list from right to left
(: foldr (-> Folder Number List Number))
(= (foldr $f $a ()) $a)
(= (foldr $f $a (Cons $x $xs))
($f $x (foldr $f $a $xs))
)

;;foldr helper function
(= (sum $z $y) (+ $z $y))
;;sum list 
(= (sum-list ()) 0)
(= (sum-list (Cons $x $xs))
      (+ $x (sum-list $xs)))


;product
(= (product ()) 1)
(= (product (Cons $x $xs))
(* $x (product $xs))
)


;;;;util to get all postive ffom list
(= (util ()) ())
(= (util (Cons $x $xs))
(if (> $x 0) (Cons $x (util $xs))
   (util $xs)))

;;compose
(= (compose $f $g)
   (Composed $f $g))

(= ((Composed $f $g) $value)
($f ($g $value)))

;;compose function arguments example

(= (cube $x) (* $x (* $x $x)))
(= (half $x) (/ $x 2))
;;;

;;curry2
(= (curry2 $f)
  (Curried2 $f))

(= ((Curried2 $f) $value)
  (Partial2 $f $value))

 (= ((Partial2  $f $val1) $val2)
    ($f $val1 $val2))

;;;;;;
;;three argument curry

;;count a memeber
(: count (-> Number List Number))
(= (count $x ()) 0)
(= (count $n (Cons $x $xs))
   (if (== $n $x) (+ 1 (count $n $xs))
                (count $n $xs)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;tests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!(length (list))
!(is-member 14 (list))
!(push 20 (list))
!(pop (list))
!(append (list2) (list))
!(max-value (list))
!(min-value (list))
!(remove-element 34 (list))
!(remove-duplicate (list))
!(filter is-positive (list))
!(map square (list))
!(reverse (list))
!(foldl product 1 (list))
!(foldr sum 0 (Cons 2 (list)))
!(sort (list))
!(sum-list (list))
!(product (list))
!(util (list))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;results
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;[6]
;[True]
;[(Cons 20 (Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 (Cons -1 ())))))))]
;[11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 (Cons -1 ())))))]
;[(Cons 10 (Cons 30 (Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 (Cons -1 ()))))))))]
;[54]
;[-1]
;[(Cons 11 (Cons 14 (Cons 54 (Cons 11 (Cons -1 ())))))]
;[(Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons -1 ())))))]
;[(Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 ())))))]
;[(Cons 121 (Cons 196 (Cons 2916 (Cons 1156 (Cons 121 (Cons 1 ()))))))]
;[(Cons -1 (Cons 11 (Cons 34 (Cons 54 (Cons 14 (Cons 11 ()))))))]
;[-3110184]
;[125]
;[(Cons -1 (Cons 11 (Cons 11 (Cons 14 (Cons 34 (Cons 54 ()))))))]
;[123]
;[-3110184]
;[(Cons 11 (Cons 14 (Cons 54 (Cons 34 (Cons 11 ())))))]
;[500]
;[2]
;[60]
















