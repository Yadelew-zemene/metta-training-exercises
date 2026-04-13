
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Type defination
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(: Heap Type)
(: Nil Heap)
(: Cons (-> Number Heap Heap))

;;Length
(: length (-> Heap Number))
(= (length Nil) 0)
(= (length (Cons $x $xs))
   (+ 1 (length $xs)))

;;get by index
(: get (-> Heap Number Number))

(= (get Nil $i) -1)
(= (get (Cons $x $xs) $i)
   (if (< $i 0)
      -1
      (if (== $i 0) $x (get $xs (- $i 1)))
      ))

;set/update element

(: set (-> Heap Number Number Heap))

(= (set Nil $i $val) Nil)
(= (set (Cons $x $xs) $i $val)
   (if (== $i 0)
       (Cons $val $xs)
       (Cons $x (set $xs (- $i 1) $val)
    )))

;swap
(: swap (-> Heap Number Number Heap))

(= (swap $heap $i $j)
   (set (set $heap $i (get $heap $j)) 
        $j 
       (get $heap $i)))
;;heapfiy during insertion()
(: heapify-up (-> Heap Number Heap))

(= (heapify-up $heap 0) $heap)
(= (heapify-up $heap $i)
   (let $parent (/ (- $i 1) 2)
     (if (< (get $heap $i) (get $heap $parent))
          (heapify-up (swap $heap $i $parent) $parent)
          $heap)))


(: append (-> Heap Heap Heap))

(= (append Nil $ys) $ys)

(= (append (Cons $x $xs) $ys)
   (Cons $x (append $xs $ys)))

;;insert
(: insert (-> Number Heap Heap))

; (= (insert $val Nil) (Cons $val Nil))

(= (insert $val $heap)
   (let $new-heap (append $heap (Cons $val Nil))
    (heapify-up $new-heap (- (length $new-heap) 1)) 
   ))
;;this takes O(n) + O(log n) ≈ O(n) due to appending o(n)

;;;;;;;;;
;;heapfiy down
(: heapify-down (-> Heap  Number Heap))

(= (heapify-down $heap $i)
   (let $l (+ (* 2 $i) 1) 
    (let $r (+ (* 2 $i) 2)
     (let $min 
         (if (and (< $l (length $heap))
                (< (get $heap $l) (get $heap $i)))
              $l 
              $i)
       (let $smallest 
            (if (and (< $r (length $heap))
                     (< (get $heap $r ) (get $heap $min)))
               $r 
               $min)
                (if (== $smallest $i)
                    $heap
                   (heapify-down (swap $heap $i $smallest) $smallest)))))))

;;delete min helper
(: delete-last (-> Heap Heap))

 (= (delete-last Nil) Nil)

(= (delete-last (Cons $x $xs))
    (if (== $xs Nil)
        Nil
        (Cons $x (delete-last $xs))))

;;delete min-root

(: delete-min (-> Heap Heap))

(= (delete-min Nil) Nil)

(= (delete-min (Cons $x Nil)) Nil)

(= (delete-min $heap)
   (let $last-index (- (length $heap) 1)
        (let $h (swap $heap 0 $last-index)
             (let $reduced (delete-last $h)
                (heapify-down $reduced 0)))))

;;make sorted list from heap
(: heap-sort (-> Heap Heap))

 (= (heap-sort Nil) Nil)

(= (heap-sort (Cons $x $xs)) 
      (Cons  $x 
       (if (== $xs Nil)
           Nil
           (heap-sort (delete-min (Cons $x $xs) ))))) 

(: build-heap (-> Heap Number Heap))

(= (build-heap $heap $i)
   (if (< $i 0)
       $heap
       (build-heap (heapify-down $heap $i) (- $i 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;tests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 

(: heap (-> Heap))
(: list (-> Heap))

(= (list) (Cons 5 (Cons 2 (Cons 4 (Cons 3 (Cons 1 Nil))))))
(= (heap) (build-heap (list) (/ (length (list)) 2)))

!(heap)
!(get (heap) 2)
!(insert 0 (heap))
 !(delete-min (heap));
!(heap-sort (heap))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;resuts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;[(Cons 1 (Cons 2 (Cons 4 (Cons 3 (Cons 5 Nil)))))]
;[4]
;[(Cons 0 (Cons 2 (Cons 1 (Cons 3 (Cons 5 (Cons 4 Nil)))))), (Cons 0 (Cons 2 (Cons 1 (Cons 3 (Cons 5 (Cons 4 Nil))))))]
;[(Cons 2 (Cons 3 (Cons 4 (Cons 5 Nil))))]
;[(Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 Nil)))))]

