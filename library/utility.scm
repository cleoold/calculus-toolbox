#lang scheme/base

(require scheme/math)

(provide round-off
         numberlist?
         disf)

;; rounds off extra digits of a number given digits to keep
(define (round-off my-num digits)
  (let ((power (expt 10 digits)))
    (/ (round (* power my-num)) power)))

;; checks whether a list is purely number-composed
(define (numberlist? lst)
  (or (null? lst)
      (and (number? (car lst)) (numberlist? (cdr lst)))))

;; compoese display and format functions
(define disf (compose display format))