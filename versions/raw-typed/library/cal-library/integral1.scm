#lang typed/racket/base

(provide area-fx-rectangular)

(: area-sq (-> Number Number Number Number))
(define (area-sq x-1 x-2 height) (* (- x-2 x-1) height))

(: area/acc/temp ((Number -> Number) Real Real Number Real ((Listof Number) -> Number) -> Number))
(define (area/acc/temp f b step x-1 x-2 method)
  (cond
    ((>= x-2 b) (area-sq x-1 b (f (method (list x-1 b)))))
    (else (+ (area-sq x-1 (+ x-2 step) (f (method (list x-1 (+ x-2 step)))))
             (area/acc/temp f b step (+ x-1 step) (+ x-2 step) method)))))

(: area-fx-rectangular ((Number -> Number) Real Real Real -> Number))
(define (area-fx-rectangular f a b step)
  (area/acc/temp f b step a a
    (lambda (interval) (/ (+ (car interval) (cadr interval)) 2))))