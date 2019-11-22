
;;; safe-balance.rkt
;;; usage: (load "safe-balance.rkt")

;;; mk-balance : nat? -> balance?
(require "../object-impl/obj.rkt")

(define mk-balance 
  (lambda (init)
    (let ([balance init])
      (let ([show (lambda ()
                       balance)]
               [deposit (lambda (d)
                          (set! balance (+ balance d)))]
               [withdraw (lambda (w)
                           (if (< balance w)
                               (error 'balance "insufficient balance")
                               (set! balance (- balance w))))])
        (let ([a (obj '())])
          (begin
            (a 'show show)
            (a 'deposit deposit)
            (a 'withdraw withdraw)
            a))))))

(define fcall 
  (lambda (obj fn-name . args)
    (let ([fn (obj fn-name)])
      (apply fn args))))

(require rackunit)
(define a (mk-balance 100))
(check-equal? (fcall a 'show) 100 "a-show")
(check-exn exn:fail? (lambda () (fcall a 'withdraw 300)) "a-withdraw-error")
