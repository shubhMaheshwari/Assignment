
(define fact
  (lambda (n)
    (letrec ([helper (lambda (i a)
                       (if (= i 0)
                           a
                           (helper (sub1 i) (* a i))))])
      (helper n 1))))
