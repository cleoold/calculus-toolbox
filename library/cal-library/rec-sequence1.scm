#lang scheme/base

(require scheme/math)

(provide recursive-sequence1
         recursive-sequence2)

(define (recursive-sequence1 A f)
  (lambda (n)
    (cond
      ((= n 0) A)
      (else
       (define (adder a counter)
         (cond ((= n counter) (f a))
               (else (adder (f a) (add1 counter)))))
       (adder A 1)))))


(define (recursive-sequence2 A B f)
  (lambda (n)
    (cond
      ((= n 0) A)
      ((= n 1) B)
      (else
       (define (adder a b counter)
         (cond ((= n counter) (f a b))
               (else (adder b (f a b) (add1 counter)))))
       (adder A B 2)))))
