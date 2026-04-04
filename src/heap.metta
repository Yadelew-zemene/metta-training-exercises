;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 ;;Type defination
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(: Heap Type)
(: Nil Heap)
(: Cons (-> Number Heap Heap))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
            ;;insert
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(: insert (-> Number Heap Heap))
(= (insert $x Nil) (Cons $x Nil))
(= (insert $x (Cons $y $ys))
    (if (<= $x $y)
         (Cons $x (Cons $y $ys)) 
         (Cons $y (insert $x $ys))
   )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;                 delete the min
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(: delete-min (-> Heap Heap))
(= (delete-min Nil) Nil)
(= (delete-min (Cons $x $xs)) $xs)
;;get min value
(: get-min (-> Heap Number))
(= (get-min Nil) 0)
(= (get-min (Cons $x $xs)) $x)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; heap to sorted list
;;it may be simple because heap is already sorted
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(: heap-to-list (-> Heap Heap))
(= (heap-to-list $h) $h)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ;;Build heap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(: build-heap (-> Heap Heap))
(= (build-heap Nil) Nil)
(= (build-heap (Cons $x $xs)) 
(insert $x (build-heap $xs))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(= (list) (Cons 3 (Cons 1 (Cons 4 (Cons 2 Nil)))))
;; Build heap first
(= (h) (build-heap (list)))

!(heap-to-list (h))
!(insert 2 (h))
!(delete-min (h))
!(get-min (h))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Results
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [(Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil))))]
; [(Cons 1 (Cons 2 (Cons 2 (Cons 3 (Cons 4 Nil)))))]
; [(Cons 2 (Cons 3 (Cons 4 Nil)))]
; [1]
