
(define x 3)
(define f 
  (lambda ()
    (begin
      (set! x 0)
      5)))

(f) ; => 5
x ; => 0
