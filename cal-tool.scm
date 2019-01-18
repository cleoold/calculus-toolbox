#lang scheme/base

(require "text-msg.scm"
         "library/numberlist-check.scm"
         "library/cal-library/newton-solve.scm"
         "library/cal-library/derivative-single-var.scm"
         "library/cal-library/integral1.scm"
         "library/la-library/vec-mag.scm")

(require scheme/local)

(provide caltool-main)

(define ns (make-base-namespace))

(display caltool-intro-msg)

(define (caltool-main)
  (display caltool-select-main)
  (define usr-main (read))
  (cond ((eq? usr-main '1)
         (newline)
         (display caltool-select-cal)
         (define usr-cal (read))
         (cond ((eq? usr-cal '1)
                (display newtonsolve-intro-msg)
                (newton-solve-application))
               ((eq? usr-cal '2)
                (display derivative-intro-msg)
                (derivative-application))
               ((eq? usr-cal '3)
                (display integral-intro-msg)
                (integral-application))
               (else
                (display caltool-inc-order)
                (caltool-main))))
        ((eq? usr-main '2)
         (newline)
         (display caltool-select-vec)
         (define usr-vec (read))
         (cond ((eq? usr-vec '1)
                (display mag-intro-msg)
                (magnitude-application))
               (else
                (display caltool-inc-order)
                (caltool-main))))
        ((eq? usr-main 'q)
         (exit))
        (else
         (display caltool-inc-order)
         (caltool-main))))
         


(define (newton-solve-application)
  (display newtonsolve-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display newtonsolve-ask-guess)
  (define guess (read))
  (display newtonsolve-ask-prec)
  (define step-differential (read))
  (display newtonsolve-ask-recur)
  (define step-recursive (read))
  (cond ((and (procedure? f) (number? guess)
              (number? step-differential) (number? step-recursive)
              (> step-recursive 0))
         (newline)
         (display ((newton-solve f guess step-differential) step-recursive)))
        (else
         (display newtonsolve-inc-func)
         (newton-solve-application)))
  (local
    ((define (break-pt local-guess local-prec local-step)
       (display newtonsolve-ask-msg)
       (define order (read))
       (cond
         ((eq? order '1)
          (display newtonsolve-ask-guess)
          (define new-guess (read))
          (display ((newton-solve f new-guess local-prec) local-step))
          (break-pt new-guess local-prec local-step))
         ((eq? order '2)
          (display newtonsolve-ask-prec)
          (define new-step-differential (read))
          (display ((newton-solve f local-guess new-step-differential) local-step))
          (break-pt local-guess new-step-differential local-step))
         ((eq? order '3)
          (display newtonsolve-ask-recur)
          (define new-step-recursive (read))
          (display ((newton-solve f local-guess local-prec) new-step-recursive))
          (break-pt local-guess local-prec new-step-recursive))
         ((eq? order '4)
          (newton-solve-application))
         ((eq? order 'q)
          (caltool-main))
         (else
          (display caltool-inc-order)
          (break-pt local-guess local-prec local-step)))))
    (break-pt guess step-differential step-recursive)))


(define (derivative-application)
  (display derivative-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display derivative-ask-point)
  (define point (read))
  (display derivative-ask-prec)
  (define precision (read))
  (cond ((and (procedure? f) (number? point) (number? precision))
         (newline)
         (display (right-derivative f point precision)))
        (else
         (display derivative-inc-func)
         (derivative-application)))
  (local
    ((define (break-pt local-point local-prec)
       (display derivative-ask-msg)
       (define order (read))
       (cond
         ((eq? order '1)
          (display derivative-ask-point)
          (define new-point (read))
          (display (right-derivative f new-point local-prec))
          (break-pt new-point local-prec))
         ((eq? order '2)
          (display derivative-ask-prec)
          (define new-precision (read))
          (display (right-derivative f local-point new-precision))
          (break-pt local-point new-precision))
         ((eq? order '3)
          (derivative-application))
         ((eq? order 'q)
          (caltool-main))
         (else
          (display caltool-inc-order)
          (break-pt local-point local-prec)))))
    (break-pt point precision)))


(define (integral-application)
  (display integral-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display integral-ask-pointa)
  (define a (read))
  (display integral-ask-pointb)
  (define b (read))
  (display integral-ask-prec)
  (define precision (read))
  (cond ((and (procedure? f) (number? a) (number? b) (number? precision))
         (newline)
         (display (area-fx-rectangular f a b precision)))
        (else
         (display integral-inc-func)
         (integral-application)))
  (local
    ((define (break-pt local-a local-b local-prec)
       (display integral-ask-msg)
       (define order (read))
       (cond
         ((eq? order '1)
          (display integral-ask-pointa)
          (define new-a (read))
          (display integral-ask-pointb)
          (define new-b (read))
          (display (area-fx-rectangular f new-a new-b local-prec))
          (break-pt new-a new-b local-prec))
         ((eq? order '2)
          (display integral-ask-prec)
          (define new-precision (read))
          (display (area-fx-rectangular f local-a local-b new-precision))
          (break-pt local-a local-b new-precision))
         ((eq? order '3)
          (integral-application))
         ((eq? order 'q)
          (caltool-main))
         (else
          (display caltool-inc-order)
          (break-pt local-a local-b local-prec)))))
    (break-pt a b precision)))






















(define (magnitude-application)
  (display mag-ask-vec)
  (define u (read))
  (cond ((and (list? u) (numberlist? u))
         (newline)
         (display (vec-mag u)))
        (else
         (display mag-inc-vec)
         (magnitude-application)))
  (local
    ((define (break-pt)
       (display mag-ask-msg)
       (define order (read))
       (cond ((eq? order '1)
              (display mag-ask-vec)
              (define new-u (read))
              (display (vec-mag new-u))
              (break-pt))
             ((eq? order 'q)
              (caltool-main))
             (else
              (display caltool-inc-order)
              (break-pt)))))
    (break-pt)))



























