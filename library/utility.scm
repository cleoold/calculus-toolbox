#lang scheme/base

(require scheme/math)

(provide round-off
         numberlist?
         disf)

(define (round-off my-num digits)
  (let ((power (expt 10 digits)))
    (/ (round (* power my-num)) power)))


(define (numberlist? lst)
  (or (null? lst)
      (and (number? (car lst)) (numberlist? (cdr lst)))))


(define disf (compose display format))