#lang scheme/base

(require scheme/math)

(provide p-derivative
         lr-second-p-derivative)


(define (modify-variable vars x0 my-var op)
  (foldr
   (lambda (x0_1 x_1 rr)
     (cond [(eq? x_1 my-var) (cons (op x0_1) rr)]
           [else (cons x0_1 rr)]))
   null x0 vars))


(define (p-derivative f vars x0 my-var step)
  (/ (- (apply f (modify-variable vars x0 my-var (lambda (x) (+ x step))))
        (apply f x0))
     step))


(define (lr-second-p-derivative f vars x0 my-var step)
  (define l (/ (- (apply f x0)
                  (apply f (modify-variable vars x0 my-var (lambda (x) (- x step))))) step))
  (define r (/ (- (apply f (modify-variable vars x0 my-var (lambda (x) (+ x step))))
                  (apply f x0)) step))
  (/ (- r l) step))