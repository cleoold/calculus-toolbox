#lang scheme/base

(require scheme/math)

(provide curve-length)


(define (rec-distance f x1 x2)
  (sqrt (+ (sqr (- x2 x1)) (sqr (- (f x2) (f x1))))))

(define (curve-length/acc f b step x-1 x-2)
  (cond
    ((>= x-2 b) (rec-distance f x-1 b))
    (else (+ (rec-distance f x-1 (+ x-2 step))
             (curve-length/acc f b step (+ x-1 step) (+ x-2 step))))))

(define (curve-length f a b step)
  (curve-length/acc f b step a a))