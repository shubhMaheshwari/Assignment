#lang racket
(require rackunit)
(require racket/list)
(require racket/contract)
(provide obj)
(provide mcall)
(provide new)

(define p (cons 'anil 25))
(check-equal? (car p) 'anil)
(check-equal? (cdr p) 25)
(check-equal? (pair? p) #t)
(define alist '((x . 3) (y . 4)))

(check-equal? 
 (assoc 'x alist)
 '(x . 3))

(check-false (assoc 'z alist))
(define obj
  (lambda (env)
    (let ([h (make-hash env)])
      (lambda (field . args) ; field: symbol?
        (let ([raise-error 
               (lambda ()
                 (error 
                  'obj
                  "field ~a not found" 
                  field))])
          (cond
            [(null? args)  ; it's a get
             (hash-ref 
              h field raise-error)]
          
            [else          ; it's a set 
             (let ([val (first args)])
               (hash-set! h field val))]))))))

(define b (obj '((x . 4) (y . 5))))

;; (b 'x) => 4
(check-equal? (b 'x) 4 "obj-test-1") 

;; (b 'x 7)
(check-equal? (b 'x 7) (void) "obj-test-2") 

;; (b 'x) => 7
(check-equal? (b 'x) 7 "obj-test-3") 
;; (b 'z) ; error
(check-exn exn:fail?
           (lambda ()
             (b 'z))
           "new-field:1")

;; (b 'z 8)
(check-equal? (b 'z 8) (void) "new-field:2")

;; (b 'z) ; => 8
(check-equal? (b 'z) 8 "new-field:3")

(define mcall
  (lambda (obj method-name . args) ; 
    (let ([method (obj method-name)])
      (apply method (cons obj args)))))

;; (mcall pt 'dist)  ; => 7
(define new
  (lambda (constructor . args)
    (let ([a (obj '())])
      (begin
        (apply constructor (cons a args))
        a))))

(define p1 (new point 2 3))
    
(check-equal? (p1 'x) 2 "p1-x")
(check-equal? (p1 'y) 3 "p1-y")
;; dist : point? -> nat?
(define dist
  (lambda (this)
    (+ (this 'x)  (this 'y))))
(define  pt (obj '((x . 3) (y . 4))))
(pt 'dist dist) ; installs 'dist on pt
(pt 'dist)      ; => procedure 
(check-true (procedure? (pt 'dist)) "pt-1")

;; ((pt 'dist) pt) ; => 7
(check-equal? ((pt 'dist) pt) 7 "pt-2")
(define move-x
  (lambda (this dx)
    (let ([x (this 'x)])
      (this 'x (+ x dx)))))

;;; install 'move-x
(pt 'move-x move-x)

(mcall pt 'move-x 2)

(check-equal? (pt 'x) 5 "move-x:1")
;;; point : obj? length? length? -> void?
(define point
  (lambda (this x y)
    (begin
      (this 'x x)
      (this 'y y)
      (this 'type 'point))))
