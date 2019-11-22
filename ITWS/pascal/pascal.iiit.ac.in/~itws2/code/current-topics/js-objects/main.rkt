(define a (obj '((x . 2) (y . 3))))
(define b (obj '((x . 1) (y . 6))))
(define dist
  (lambda (this)
    (+ (this 'x) (this 'y))))

(dist a) ; => 5
(dist b) ; => 7
(a 'dist dist) ; install dist against name 'dist
(mcall a 'dist) ; => 5

(define bind
  (lambda (m o)
    (lambda (ignore-obj . args)
      (apply m (cons o args)))))

((bind dist b) a) ; => 17
