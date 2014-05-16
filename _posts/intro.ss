(define (length l)
  (cond
   ((null? l) 0)
   ((pair? l)
    (+ 1 (length (cdr l))))
   (else
    (error "invalid argument to length"))))

(define (pair-copy pr)
  (cons (car pr) (cdr pr)))

(define (pair-tree-deep-copy thing)
  (if (not (pair? thing)) thing
      (cons (pair-tree-deep-copy (car thing))
            (pair-tree-deep-copy (cdr thing)))))

