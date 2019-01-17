#lang typed/racket/base

(require racket/local)

(provide recursive-sequence1
         recursive-sequence2)

(: recursive-sequence1 (Number (Number -> Number) -> (Natural -> Number)))
(define (recursive-sequence1 A f)
  (lambda (n)
    (cond
      ((= n 0) A)
      (else
       (local
         ((: adder (Number Natural -> Number))
          (define (adder a counter)
            (cond ((= n counter) (f a))
                  (else (adder (f a) (add1 counter))))))
         (adder A 1))))))


(: recursive-sequence2 (Number Number (Number Number -> Number) -> (Natural -> Number)))
(define (recursive-sequence2 A B f)
  (lambda (n)
    (cond
      ((= n 0) A)
      ((= n 1) B)
      (else
       (local
         ((: adder (Number Number Natural -> Number))
          (define (adder a b counter)
            (cond ((= n counter) (f a b))
                  (else (adder b (f a b) (add1 counter))))))
         (adder A B 2))))))
