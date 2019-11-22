
(lambda (x)
  (+ x y))

((lambda (x)
  (+ x y))
  5)

(let ([x 5])
   (letrec ([x (lambda ()
                 x))]
     x))

((let ([x 5])
   (letrec ([x (lambda ()
                 x)])
     x)))

((let ([x 5])
   (letrec ([x (lambda ()
                 x)])
     x)))

#lang racket
(define x 3)
(define y 4)

((lambda (x)
  (+ x y))
  5)
