#lang scheme/base

(require scheme/math)

(provide right-derivative)

(define (right-derivative f x0 step)
  (/ (- (f (+ x0 step)) (f x0)) step))

#|
(define (left-derivative f x0 step)
  (/ (- (f x0) (f (- x0 step))) step))
|#;