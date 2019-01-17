#lang typed/racket/base

(provide numberlist?)

(: numberlist? (-> (Listof Any) Boolean))
(define (numberlist? lst)
  (or (null? lst)
      (and (number? (car lst)) (numberlist? (cdr lst)))))