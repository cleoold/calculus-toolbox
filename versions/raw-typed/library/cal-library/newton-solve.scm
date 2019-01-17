#lang typed/racket

(require "rec-sequence1.scm"
         "derivative-single-var.scm")

(provide newton-solve)

(: newton-solve ((Number -> Number) Number Number -> (Natural -> Number)))
(define (newton-solve f guess step)
  (recursive-sequence1 guess
    (lambda (x) (- x (/ (f x) (right-derivative f x step))))))
