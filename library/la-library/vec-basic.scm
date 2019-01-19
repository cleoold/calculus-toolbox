#lang scheme/base

(require scheme/math)

(provide vec-sqr
         vec-mag
         vec-add
         vec-mult
         vec-dot)

(define (vec-sqr u)
  (apply + (map sqr u)))

(define (vec-mag u)
  (sqrt
   (vec-sqr u)))

(define (vec-add u v)
  (map + u v))

(define (vec-mult c u)
  (map (lambda (u1) (* c u1)) u))

(define (vec-dot u v)
  (foldr + 0 (map * u v)))