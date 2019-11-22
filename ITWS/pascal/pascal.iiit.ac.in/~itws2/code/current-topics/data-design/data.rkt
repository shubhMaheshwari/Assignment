
(define s (string #\a #\b)) ; => "ab"

(string-ref s 0) ; => #\a

(string-set! s 0 #\c)
(string-ref s 0) ; =#\c

(eq? '(a b c) '(a b c)) ; => #f
(equal? '(a b c) '(a b c)) ; => #t

(eq? '#(a b c) '#(a b c)) ; => #f
(equal? '#(a b c) '#(a b c)) ; => #f

(eq? "abc" "abc") ; => #t 
(equal? "abc" "abc") ; => #t 

(eq? (string '#\a '#\b) "ab") ; => #f
(equal? (string '#\a '#\b) "ab") ; => #t
