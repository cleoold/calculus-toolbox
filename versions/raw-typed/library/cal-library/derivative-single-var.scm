#lang typed/racket/base

(provide right-derivative)

(: right-derivative ((Number -> Number) Number Number -> Number))
(define (right-derivative f x0 step)
  (/ (- (f (+ x0 step)) (f x0)) step))

#|
(define (left-derivative f x0 step)
  (/ (- (f x0) (f (- x0 step))) step))
|#;