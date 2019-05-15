#lang scheme/base

(require "integral1.scm")

(require scheme/math
         "../utility.scm")

(provide left-derivative
         area-fx-rectangular-left
         area-fx-rectangular-right
         sigma bigpi
         gen-eea)

(define-syntax-rule (checkdiv f)
  (with-handlers ((exn:fail:contract:divide-by-zero?
                   (lambda (e) "div")))
    f))


(define (left-derivative f x0 step)
  (/ (- (f x0) (f (- x0 step))) step))


(define (area-fx-rectangular-left f a b step)
  (checkdiv
   (area/acc/temp f b step a a
                  (lambda (interval) (car interval)))))

(define (area-fx-rectangular-right f a b step)
  (checkdiv
   (area/acc/temp f b step a a
                  (lambda (interval) (cadr interval)))))


(define (sigma f n)
  (apply + (build-list n f)))

(define (bigpi f n)
  (apply * (build-list n f)))


;; extended euclidean algorithm. prints a list of finding bezout coefficients

(define (gen-eea a b)
  (disf "   x\ty\tr\tq\n")
  (disf "  =============================\n")
  (disf "   ~a\t~a\t~a\t~a\n" 1 0 a 0)
  (disf "   ~a\t~a\t~a\t~a\n" 0 1 b 0)
  (let loop ((s `(0 1)) (t `(1 0)) (r `(,b ,a))) ;first field: current, second field: old
    (cond
      ((= (car r) 0)
       (disf "\ngreatest common divisor: ~a\n" (abs (cadr r)))
       (disf "result from Bezout: (~a)(~a) + (~a)(~a) = ~a\n" (cadr s) a (cadr t) b (cadr r)))
      (else
       (define quo (quotient (cadr r) (car r)))
       (set! r (list (- (cadr r) (* quo (car r))) (car r)))
       (set! s (list (- (cadr s) (* quo (car s))) (car s)))
       (set! t (list (- (cadr t) (* quo (car t))) (car t)))
       (disf "   ~a\t~a\t~a\t~a\n" (car s) (car t) (car r) quo)
       (loop s t r)))))