#lang scheme/base

(require scheme/math)

(provide right-derivative
         lr-second-derivative)


(define (right-derivative f x0 step)
  (/ (- (f (+ x0 step)) (f x0)) step))


(define (lr-second-derivative f x0 step)
  (define l (/ (- (f x0) (f (- x0 step))) step))
  (define r (right-derivative f (+ x0 step) step))
  (/ (- r l) (* 2 step)))
