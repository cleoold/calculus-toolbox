#lang scheme/base

(provide dec->basen
         basen->dec)

(define (dec->basen nbase nnumber)
  (define (dec-basen/reversed nnumber)
    (if (zero? nnumber)
        null
        (cons (modulo nnumber nbase)
              (dec-basen/reversed (quotient nnumber nbase)))))
  (reverse (dec-basen/reversed nnumber)))

(define (basen->dec nbase nnumber)
  (if (zero? nnumber)
      nnumber
      (+ (modulo nnumber 10) 
         (* nbase (basen->dec nbase (quotient nnumber 10))))))
