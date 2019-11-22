(require racket/math) ; pi's definition is in the math package

(define area
  (lambda (radius)
    (* pi radius radius)))

(area 3.0) ; => 28.274333882308138
(define (twice x)
  (* 2 x))
