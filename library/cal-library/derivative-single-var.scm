#lang scheme/base

(require scheme/math)

(provide right-derivative
         lr-second-derivative)

;; helper
(define (halving-loop algo f x0 res step prec)
  (define newres (algo f x0 step))
  (cond ((< (abs (- res newres)) step)
           newres)
          (else
           (halving-loop algo f x0 newres (/ step 2) prec))))

;;==========================

(define (right-derivative-algo f x0 step)
  (/ (- (f (+ x0 step)) (f x0)) step))

(define (right-derivative f x0 prec)
  (halving-loop right-derivative-algo f x0 0 1 prec))




(define (lr-second-derivative-algo f x0 step)
  (define l (/ (- (f x0) (f (- x0 step))) step))
  (define r (right-derivative-algo f (+ x0 step) step))
  (/ (- r l) (* 2 step)))

(define (lr-second-derivative f x0 prec)
  (halving-loop lr-second-derivative-algo f x0 0 1 prec))