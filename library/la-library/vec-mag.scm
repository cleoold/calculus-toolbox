#lang scheme

(provide vec-mag)

(define (vec-mag u)
  (sqrt
   (apply + (map sqr u))))