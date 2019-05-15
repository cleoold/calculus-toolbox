#lang scheme/base

(require scheme/math)
(require "../utility.scm")

(provide recursive-sequence1
         recursive-sequence2
         recursive-sequence1-display
         recursive-sequence2-display)

(define (recursive-sequence1 A f)
  (lambda (n)
    (cond
      ((= n 0) A)
      (else
       (define (adder a counter)
         (cond ((= n counter) (f a counter))
               (else (adder (f a counter) (add1 counter)))))
       (adder A 1)))))


(define (recursive-sequence2 A B f)
  (lambda (n)
    (cond
      ((= n 0) A)
      ((= n 1) B)
      (else
       (define (adder a b counter)
         (cond ((= n counter) (f a b counter))
               (else (adder b (f a b counter) (add1 counter)))))
       (adder A B 2)))))


;; below print a list for a recurrence sequence

(define (recursive-sequence1-display A f from to)
  (cond
    ((>= from 0)
     (define a0 ((recursive-sequence1 A f) from))
     (for ((k (in-range from to)))
       (disf "   a[~a] = ~a\n" k a0)
       (set! a0 (f a0 (+ k 1)))))
    (else (recursive-sequence1-display A f 0 to))))


(define (recursive-sequence2-display A B f from to)
  (cond
    ((>= from 0)
     (define a0 ((recursive-sequence2 A B f) from))
     (define b0 ((recursive-sequence2 A B f) (add1 from)))
     (define temp 0)
     (for ((k (in-range from to)))
       (disf "   a[~a] = ~a\n" k a0)
       (set! temp (f a0 b0 (+ k 2)))
       (set! a0 b0)
       (set! b0 temp)))
    (else (recursive-sequence2-display A B f 0 to))))

