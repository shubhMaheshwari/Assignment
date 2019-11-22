
(lambda (x y)   ; these are binding occurrences of x and y
  (+ x y)       ; these are reference occurrences  x and y

(define f                      ; 1  binding occurrence of f
  (lambda (n)                  ; 2  binding occurrence of n
    (if (= n 0)                ; 3  reference occurrence of n 
        1                      ; 4   
        (* n (f (sub1 n))))))  ; 5  reference occurrences of n and f

(+ x                   ; 1  reference occurrence of x
   (lambda (x)         ; 2  binding occurrence of x
     (let ([y 5])      ; 3  binding occurrence of y
       (+ x y z))))    ; 4  reference occurrences of
                       ;    x, y and z

(+ x                    ; 1  free reference occurrence of x
   (lambda (x)          ; 2  binding occurrence of x
     (let ([y  x])      ; 3  binding occurrence of y, 
                        ;    reference occurrence of x bound (to binding occurrence
                        ;    of x) on line 2 
        (+ y            ; 4  bound to the binding occurrence of x on line 2
           x            ; 5  bound to the binding occurrence of y on line 3
           z))))        ; 6  free reference occurrence of z

(letrec ([x (lambda () y)]        ; 1. reference occurrence y is bound to 
                                  ;    binding occurrence of y in line 2

         [y (lambda () x)])       ; 2. reference occurrence x is bound to 
                                  ;    binding occurrence of y in line 2

   x)                             ; 3. reference occurrence of x is bound to 
                                  ;    binding occurrence of x in line 1   

(let    ([x (lambda () y)]        ; 1. reference occurrence y is free


         [y (lambda () x)])       ; 2. reference occurrence x is free

   x)                             ; 3. reference occurrence of x is bound to 
                                  ;    binding occurrence of x in line 1   

(define f             ; 1 binding occurrence of f
   (lambda ()         ; 2
     f))              ; 3 reference occurrence of f bound to 
                      ;   the binding occurrence of f on line 1

(+ x                   ; 1   reference occurrence of x
   (let ([x 5]         ; 2   binding occurrence of x as a bind identifier
         [y            ; 3   binding occurrence of y as a bind identifier
           (+ x 2)])   ; 4   reference occurence of x
    (+ x               ; 5   reference occurrence of x
       y)))            ; 6   reference occurrence of y
