
#lang racket

;;; celsius->fahrenheit

;;; Purpose
;;; =======

;;; This function takes temperature expressed 
;;; in celsius and returns
;;; equivalent temperature in fahrenheit.

;;; Usage
;;; =====
;;; (celsius->fahrenheit 0) 
;;;  => 32.0 (approximately)
;;; (celsius->fahrenheit 100) 
;;; ; => 212.0  (approximately)

;;; Signature
;;; =========
;;;  celsius->fahrenheit : temperature? -> temperature?

;;; Definitions
;;; ===========




;; celsius->fahrenheit : temperature? -> temperature?
(define celsius->fahrenheit
  (lambda (c)
    (+ (* c 1.8) 32)))

(require rackunit)
(require rackunit/text-ui)


(check-= 
 (celsius->fahrenheit 0.0) 
 32.0 "c0"))


;;; Approximate equality
;;; check-approx checks if two numbers are within 0.01 of each other.
;;; check-approx-= : number? number? -> void? 
(define check-approx-=
  (lambda (v1 v2)
    (check-= v1 v2 0.01)))

(check-approx-= 
 (celsius->fahrenheit 0.0)
 32.0 "c1"))

(check-approx-=
 (celsius->fahrenheit 100.0)
 212.0 "c2"))
