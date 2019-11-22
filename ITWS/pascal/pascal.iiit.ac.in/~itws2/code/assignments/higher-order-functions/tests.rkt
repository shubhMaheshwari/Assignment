#lang racket
(require rackunit)
(require racket/list)
(require "main.rkt")
(define binary-and 
  (lambda (x y)
    (and x y)))

(define (all-satisfy predicate ls) 
  (reduce binary-and #t (map predicate ls)))

(check-equal?  (all-satisfy even? '(2 3 4)) #f "All-even-test #f")
(check-equal?  (all-satisfy even? '(2 4 6)) #t "All-even-test #t")
(check-equal?  (all-satisfy boolean? '(#t #f 6)) #f "All-boolean-test #f")
(check-equal?  (all-satisfy boolean? '(#t #f #t)) #t "All-boolean-test #t")

(define next-even? (compose even? add1))
(check-equal? (next-even? 4) #f "compose-t1")
(check-equal? (next-even? 5) #t "compose-t2")
(define mul2
 (lambda (x) (* x 2)))

(define f (compose* add1 mul2 sub1))
(check-equal? (f 4) 7 "f 4")
(check-equal? (f 7) 13 "f 7")
(check-equal? (reverse '(a b c)) '(c b a) "Reverse (a b c)")
(check-equal? (reverse '(1 2 3 4)) '(4 3 2 1) "Reverse (1 2 3 4)")
(check-equal? (list-length '(a b c)) 3 "List Length (a b c)")
(check-equal? (list-length '(1 2 3 4)) 4 "List Length (1 2 3 4)")
(define sum (reduce-curried + 0))
(define product (reduce-curried * 1))
(check-equal? (sum '(1 2 3 4 5 6)) 21 "Reduce-curried: sum-test")
(check-equal? (product '(4 5 6)) 120 "Reduce-curried: product-test")
(check-equal? (list-map add1 '(1 2 3 4)) '(2 3 4 5) "test 1")
(check-equal? (list-map boolean? '(1 #t #f 4)) '(#f #t #t #f) "test 2")
(define equilateral-triangle-area
  (lambda (side)
    (* (/ (sqrt 3) 4) side side)))

(define square-area
  (lambda (side)
    (* side side)))

(define circle-area
  (lambda (radius)
    (* pi radius radius)))


(define square-perimeter
    (lambda (side)
        (* 4 side)))

(define equilateral-triangle-perimeter
    (lambda (side)
        (* 3 side)))

(define circle-perimeter
    (lambda (radius)
        (* 2 pi radius)))


(check-equal? (area (triangle 3)) (equilateral-triangle-area 3) "Triangle
area test")

(check-equal? (area (square 4)) (square-area 4) "Square area test")
(check-equal? (area (circle 4)) (circle-area 4) "Circle atrea test")

(check-equal? (perimeter (triangle 3)) (equilateral-triangle-perimeter 3) "Triangle
perimeter test")

(check-equal? (perimeter (square 4)) (square-perimeter 4) "Square perimeter test")
(check-equal? (perimeter (circle 4)) (circle-perimeter 4) "Circle perimeter test")
  (define test-point (rectangular 3.0 4.0))
  (check-equal? (get-x test-point) 3.0 "get-x test")
  (check-equal? (get-y test-point) 4.0 "get-y test")
  (check-equal?
   (point-equal?
    (polar-to-rectangular (rectangular-to-polar test-point))
    test-point)
   #t
   "conversion-equality test")

  (define polar-test-point (polar 5.0 2.0))
  (check-equal? (get-r polar-test-point) 5.0 "get-r test")
  (check-equal? (get-t polar-test-point) 2.0 "get-t test")
  (check-equal?
   (point-equal?
    (rectangular-to-polar (polar-to-rectangular polar-test-point))
    polar-test-point)
   #t
   "polar conversion-equality test")
