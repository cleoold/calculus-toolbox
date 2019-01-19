#lang scheme/base

(require scheme/math)

(provide vec-mag)

(define (vec-mag u)
  (sqrt
   (foldr (lambda (x rr) (+ (expt x 2) rr)) 0 u)))