#lang scheme/base

(require scheme/math)

(require "vec-basic.scm")

(provide proj
         perp
         refl)

(define (proj u x)
  (vec-mult
   (/ (vec-dot x u) (vec-sqr u)) u))

(define (perp u x)
  (vec-add x (vec-mult -1 (vec-mult (/ (vec-dot x u) (vec-sqr u)) u))))

(define (refl n x)
  (vec-add x (vec-mult -2 (vec-mult (/ (vec-dot x n) (vec-sqr n)) n))))
