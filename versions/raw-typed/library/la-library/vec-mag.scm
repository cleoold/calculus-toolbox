#lang typed/racket/base

(provide vec-mag)

(: vec-mag (-> (Listof Number) Number))
(define (vec-mag u)
  (sqrt
   (apply + (map (lambda ((x : Number)) (expt x 2)) u))))