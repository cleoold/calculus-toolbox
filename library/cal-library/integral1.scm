#lang scheme/base

(require scheme/math)

(provide area-fx-rectangular
         area/acc/temp
         curve-length)

(define-syntax-rule (checkdiv f)
  (with-handlers ((exn:fail:contract:divide-by-zero?
                   (lambda (e) "div")))
    f))


(define (area-sq x-1 x-2 height) (* (- x-2 x-1) height))

(define (area/acc/temp f b step x-1 x-2 method)
  (cond
    ((>= x-2 b) (area-sq x-1 b (f (method (list x-1 b)))))
    (else (f x-1) ; magik, checks whether f(x-1) between f(a), (b) is valid; still needs a handler
          (+ (area-sq x-1 (+ x-2 step) (f (method (list x-1 (+ x-2 step)))))
             (area/acc/temp f b step (+ x-1 step) (+ x-2 step) method)))))

(define (area-fx-rectangular f a b step)
  (checkdiv
   (area/acc/temp f b step a a
                  (lambda (interv) (/ (+ (car interv) (cadr interv)) 2)))))


;; curve length ------------------------------------------
(define (rec-distance f x1 x2)
  (sqrt (+ (sqr (- x2 x1)) (sqr (- (f x2) (f x1))))))

(define (curve-length/acc f b step x-1 x-2)
  (cond
    ((>= x-2 b) (rec-distance f x-1 b))
    (else (f x-1)
          (+ (rec-distance f x-1 (+ x-2 step))
             (curve-length/acc f b step (+ x-1 step) (+ x-2 step))))))

(define (curve-length f a b step)
  (checkdiv
   (curve-length/acc f b step a a)))
;; -------------------------------------------------------
