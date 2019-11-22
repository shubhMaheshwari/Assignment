
;;; celsius? : any/c -> boolean? 
(define celsius?
  (lambda (data)
    (and (list? data)
         (= 2 (length data))
         (eq? (first data)
              'celsius)
         (real? (second data)))))

;;; celsius : real? -> celsius?
(define celsius
  (lambda (temp)
    (list 'celsius temp)))

;;; celsius->magnitude : celsius? -> real?
(define celsius->magnitude
  (lambda (cel)
    (second cel)))

;;; [any/c, any/c] -> boolean?
(define celsius-equal?
  (lambda (c1 c2)
    (and (celsius? c1)
         (celsius? c2)
         (equal? c1 c2))))

(require racket/contract)
(define temperature?
  (or/c celsius? fahrenheit?))
