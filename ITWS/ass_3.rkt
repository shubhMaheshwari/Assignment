#lang racket
(require rackunit)
(define split-list
  (λ (LIST num)
    (letrec ([func (λ (ls num ls1 ls2)
                     (if(null? ls) (list ls1 ls2)
                        (func (rest ls) num (if (>= num (first ls)) (append ls1 (list (first ls))) (append ls1 '())) (if (< num (first ls)) (append ls2 (list (first ls))) (append ls2 '())))
                     )
                     )])
      (func LIST num '() '())
      )

    )
  )

(check-equal? (split-list '() 3) '(() ()) "test 1")
(check-equal? (split-list '(1 2 3 4) 5) '((1 2 3 4) ()) "test 2")
(check-equal? (split-list '(3 1 2 6 5 7 5) 5) '((3 1 2 5 5) (6 7)) "test 3")
(check-equal? (split-list '(3 1 2 6 5 7 5) 0) '(() (3 1 2 6 5 7 5)) "test 4")

(define flatten-list
  (λ (ls)
    (let ([list ls] [brac (λ (lst) (if(list? (first lst)) (null? (first list)) (append ls (first lst))))])
     (if
     (null? list)
       '() 
     (flatten ls)
    )
  ))
)

(check-equal? (flatten-list '()) '() "test 1")
(check-equal? (flatten-list '((1) () (2))) '(1 2) "test 2")
(check-equal? (flatten-list '((1 2) ())) '(1 2) "test 3")
(check-equal? (flatten-list '(() (1) (3 4))) '(1 3 4) "test 4")
(check-equal? (flatten-list '(1 (2 (3 4) 5) 6)) '(1 2 3 4 5 6) "test 5")

(define reduce
 (λ (f init ls)
	(if (null? ls) init (reduce f (f init (first ls)) (rest ls)))
	      )
	)

(define reduce*
  (λ (f init ls)
    (reduce f init (flatten-list ls))
    )

  )

 (define (binary-and x y)
    (and x y))

  (check-equal? (reduce* binary-and #t '((#t #t) (#t #t) #f)) #f "test 1")
  (check-equal? (reduce* binary-and #t '(#t (#t #t))) #t "test 2")
  (check-equal? (reduce* + 0 '(1 (2 3) (4 5))) 15 "test 3")
  (check-equal? (reduce* * 1 '((3 5) (2))) 30 "test 4")


(define map*
	  (λ (func ls)
	    (let [(oper (λ (ls val)
	(cons (if(list? val) (map* func val) (func val)) ls)
	    )
		        )]
	     (reverse (reduce oper '() ls))
	    )
	    )
	  )

(check-equal? (map* even? '(2 (4 3) ())) '(#t (#t #f) ()) "test 1")
  (check-equal? (map* add1 '((1 2) 3 (4 5) (6 7))) '((2 3) 4 (5 6) (7 8)) "test 2")
  (check-equal? (map* boolean? '(1 #t #f -2 0)) '(#f #t #t #f #f) "test 3")
