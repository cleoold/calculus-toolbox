#lang scheme/base

(require scheme/math)

(provide p-derivative)

(define (p-derivative f vars x0 my-var step)
  (/ (- (apply f (foldr
                  (lambda (x0_1 x_1 rr)
                    (cond ((eq? x_1 my-var) (cons (+ x0_1 step) rr))
                          (else (cons x0_1 rr))))
                  null x0 vars))
        (apply f x0))
     step))
