#lang scheme/base

(require scheme/math)

(provide area-fx-rectangular)

(define (area-sq x-1 x-2 height) (* (- x-2 x-1) height))

(define (area/acc/temp f b step x-1 x-2 method)
  (cond
    ((>= x-2 b) (area-sq x-1 b (f (method (list x-1 b)))))
    (else (+ (area-sq x-1 (+ x-2 step) (f (method (list x-1 (+ x-2 step)))))
             (area/acc/temp f b step (+ x-1 step) (+ x-2 step) method)))))

(define (area-fx-rectangular f a b step)
  (area/acc/temp f b step a a
    (lambda (interval) (/ (+ (car interval) (cadr interval)) 2))))