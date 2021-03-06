#lang scheme/base

(require scheme/math)

(require "rec-sequence1.scm"
         "derivative-single-var.scm")

(provide newton-solve)

(define (newton-solve f guess step)
  (recursive-sequence1 guess
    (lambda (x n) (- x (/ (f x) (right-derivative f x step))))))
