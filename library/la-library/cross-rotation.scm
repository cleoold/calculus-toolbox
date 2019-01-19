#lang scheme/base

(require scheme/math)

(provide vec-cross
         r2)

(define (vec-cross u v)
  (list (- (* (cadr u) (caddr v)) (* (caddr u) (cadr v)))
        (- (* (caddr u) (car v)) (* (car u) (caddr v)))
        (- (* (car u) (cadr v)) (* (cadr u) (car v)))))

(define (r2 v a)
  (list
   (- (* (cos a) (car v)) (* (sin a) (cadr v)))
   (+ (* (sin a) (car v)) (* (cos a) (cadr v)))))
