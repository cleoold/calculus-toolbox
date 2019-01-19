#lang scheme/base

(require "integral1.scm")

(require scheme/math)

(provide left-derivative
         area-fx-rectangular-left
         area-fx-rectangular-right
         sigma bigpi)


(define (left-derivative f x0 step)
  (/ (- (f x0) (f (- x0 step))) step))


(define (area-fx-rectangular-left f a b step)
  (area/acc/temp f b step a a
    (lambda (interval) (car interval))))

(define (area-fx-rectangular-right f a b step)
  (area/acc/temp f b step a a
    (lambda (interval) (cadr interval))))


(define (sigma f n)
  (apply + (build-list n f)))

(define (bigpi f n)
  (apply * (build-list n f)))