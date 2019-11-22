
(require racket/trace)
(define !
  (trace-lambda (n)
    (if (zero? n)
        1
        (* n (! (sub1 n))))))
;       ^^^^ 
;       incremental building up of context

(define !/acc
  (trace-lambda (n)
    (helper n 1)))

(define helper
  (trace-lambda (i a)
    (if (= i 0)
        a
        (helper (sub1 i) (* a i)))))
