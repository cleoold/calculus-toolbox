#lang scheme/base

(require scheme/math)

(provide numberlist?)

(define (numberlist? lst)
  (or (null? lst)
      (and (number? (car lst)) (numberlist? (cdr lst)))))