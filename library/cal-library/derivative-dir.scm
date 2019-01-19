#lang scheme/base

(require scheme/math)

(require "derivative-partial.scm")

(provide directional-derivative
         gradient)

(define (directional-derivative f vars x0 direction step)
  (foldr (lambda (vars_1 di_1 rr)
           (+ (* (p-derivative f vars x0 vars_1 step) (cos di_1)) rr))
         0 vars direction))

(define (gradient f vars x0 step)
  (foldr (lambda (vars_1 rr)
           (cons (p-derivative f vars x0 vars_1 step) rr))
         null vars))
