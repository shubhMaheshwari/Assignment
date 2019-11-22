
((compose add1 mul2) 4) ; => 9
((compose mul2 add1) 4) ; => 10

((derivative add1) 2)
((derivative mul2) 5)

;;; compose: [[B -> C], [A -> B]] ->
;;           [A -> C]
(define compose
  (lambda (f g) ;f: B->C, g:A->B
    (lambda (x) ; x:A
      (f (g x))))) ; 

(define derivative
  (let ([dx 0.1])
    (lambda (f)   ; f: real? -> real?
      (lambda (x) ; x: real?
        (/ (- (f (+ x dx))
              (f x))
           dx)))))

;;; map-add1 takes a list and adds 1 to 
;;; each element

(define map-add1
  (lambda (ls)
    (cond [(null? ls) '()]
          [else 
           (cons (add1 (first ls))
                 (map-add1 (rest ls)))])))

(define map-mul2
  (lambda (ls)
    (cond [(null? ls) '()]
          [else 
           (cons (mul2 (first ls))
                 (map-mul2 (rest ls)))])))

(define map-<f>
  (lambda (ls)
    (cond 
  	[(null? ls) '()]
    [else 
     (cons (<f> (first ls))
           (map-<f> (rest ls)))])))

;;; list-map : [A->B (listof A)] ->
;;;            (listof B)

(define list-map
  (lambda (f ls)
    (cond 
      [(null? ls) '()]
      [else (cons 
             (f (first ls))
             (list-map f (rest ls)))])))

(list-map add1 '()) ; => '()
(list-map add1 '(2 4 8)) ; => '(3 5 9)

;;; list-map-generator: [A->B] ->
;;;                     [(listof A) -> 
;;;                       (listof B)]
(define list-map-generator
  (lambda (f)
    (lambda (ls)
      (cond 
        [(null? ls) '()]
        [else (cons 
               (f (first ls))
               ((list-map-generator f)
                (rest ls)))]))))


(define list-map-add1 
  (list-map-generator add1))

;; Usage
(define map-add1 (list-map-generator/helper add1))

(define list-map-generator/helper
  (lambda (f)
    (letrec ([helper
              (lambda (ls) 
                (cond  
                  [(null? ls) '()]
                  [else (cons
                         (f (first ls))
                         (helper (rest ls)))]))])
      helper)))
