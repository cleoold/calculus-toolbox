#lang scheme/base

(require "text-msg.scm"
         "library/utility.scm"
         "library/cal-library/newton-solve.scm"
         "library/cal-library/derivative-single-var.scm"
         "library/cal-library/integral1.scm"
         "library/cal-library/rec-sequence1.scm"
         "library/cal-library/derivative-partial.scm"
         "library/cal-library/derivative-dir.scm"
         "library/cal-library/extra.scm"
         "library/cal-library/basen.scm"
         "library/la-library/vec-basic.scm"
         "library/la-library/cross-rotation.scm"
         "library/la-library/projection.scm")

(require scheme/math)

(provide caltool-main)

(define-namespace-anchor a)
(define ns (namespace-anchor->namespace a))

(display caltool-intro-msg)

;; driver programme. it links all the modules defined below into menus and submenus
;; the programme uses recursive approach
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
                (display integral-main-intro)
                (define usr-int (read))
                (cond
                  ((eq? usr-int '1)
                   (display integral-intro-msg)
                   (integral-application))
                  ((eq? usr-int '2)
                   (display curve-length-intro-msg)
                   (curve-length-application))
                  (else
                   (display caltool-inc-order)
                   (caltool-main))))             
               ((eq? usr-cal '4)
                (display recsequence-main-intro-msg)
                (display recsequence-main-select)
                (define usr-seq (read))
                (cond
                  ((eq? usr-seq '1)
                   (recsequence1-application))
                  ((eq? usr-seq '2)
                   (recsequence2-application))
                  (else
                   (display caltool-inc-order)
                   (caltool-main))))
               ((eq? usr-cal '5)
                (display partialderivative-main-intro-msg)
                (partial-application-enter-intro))
               ((eq? usr-cal '0)
                (display calcextra-intro-msg)
                (define usr-extra (read))
                (cond
                  ((eq? usr-extra '1)
                   (display calextra-derivative-intro-msg)
                   (derivative/lr-application))
                  ((eq? usr-extra '2)
                   (display calextra-integral-intro-msg)
                   (integral/lr-application))
                  ((eq? usr-extra '3)
                   (display calextra-sigma-intro-msg)
                   (sigma-application))
                  ((eq? usr-extra '4)
                   (display calextra-pi-intro-msg)
                   (bigpi-application))
                  ((eq? usr-extra '5)
                   (basen-application))
                  ((eq? usr-extra '6)
                   (display calextra-eea-intro-msg)
                   (eea-application))
                  (else
                   (display caltool-inc-order)
                   (caltool-main))))
               ((eq? usr-cal '5)
                (display partialderivative-main-intro-msg)
                (partial-application-enter-intro))
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
               ((eq? usr-vec '2)
                (display product-intro-msg)
                (product-application))
               ((eq? usr-vec '3)
                (display projection-intro-msg)
                (projection-application))
               ((eq? usr-vec '4)
                (display rotation2d-intro-msg)
                (rotation2d-application))
               (else
                (display caltool-inc-order)
                (caltool-main))))
        ((eq? usr-main 'd)
         (newline)
         (display intro-convention)
         (caltool-main))
        ((eq? usr-main 'q)
         (exit))
        (else
         (display caltool-inc-order)
         (caltool-main))))
         
;; ==============================================================

;; the submenu of newton's method.
(define (newton-solve-application)
  (display newtonsolve-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display newtonsolve-ask-guess)
  (define guess (eval (read) ns))
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
  
  ;; a new argument will be created and it will enter a recursion if the user changes one of 
  ;; his arguments. the similar approach is used for below other implementations
    (define (break-pt local-guess local-prec local-step)
       (display newtonsolve-ask-msg)
       (define order (read))
       (cond
         ((eq? order '1)
          (display newtonsolve-ask-guess)
          (define new-guess (eval (read) ns))
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
          (break-pt local-guess local-prec local-step))))
  
    (break-pt guess step-differential step-recursive))

;; ==============================================================

;; the submenu for derivative of a function
(define (derivative-application)
  (display derivative-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display derivative-ask-point)
  (define point (eval (read) ns))
  (display derivative-ask-prec)
  (define precision (read))
  (cond ((and (procedure? f) (number? point) (number? precision))
         (disf "\nfirst derivative: ~a" (right-derivative f point precision))
         (disf "\nsecond derivative: ~a" (lr-second-derivative f point precision)))
        (else
         (display derivative-inc-func)
         (derivative-application)))

    (define (break-pt local-point local-prec)
       (display derivative-ask-msg)
       (define order (read))
       (cond
         ((eq? order '1)
          (display derivative-ask-point)
          (define new-point (eval (read) ns))
          (disf "\nfirst derivative: ~a" (right-derivative f new-point local-prec))
          (disf "\nsecond derivative: ~a" (lr-second-derivative f new-point local-prec))
          (break-pt new-point local-prec))
         ((eq? order '2)
          (display derivative-ask-prec)
          (define new-precision (read))
          (disf "\nfirst derivative: ~a" (right-derivative f local-point new-precision))
          (disf "\nsecond derivative: ~a" (lr-second-derivative f local-point new-precision))
          (break-pt local-point new-precision))
         ((eq? order '3)
          (derivative-application))
         ((eq? order 'q)
          (caltool-main))
         (else
          (display caltool-inc-order)
          (break-pt local-point local-prec))))
  
    (break-pt point precision))

;; ==============================================================

;; the submenu for the definite integral of a function
(define (integral-application)
  (display integral-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display integral-ask-pointa)
  (define a (eval (read) ns))
  (display integral-ask-pointb)
  (define b (eval (read) ns))
  (display integral-ask-prec)
  (define precision (read))
  (cond ((and (procedure? f) (number? a) (number? b) (number? precision))
         (newline)
         (display (area-fx-rectangular f a b precision)))
        (else
         (display integral-inc-func)
         (integral-application)))

    (define (break-pt local-a local-b local-prec)
       (display integral-ask-msg)
       (define order (read))
       (cond
         ((eq? order '1)
          (display integral-ask-pointa)
          (define new-a (eval (read) ns))
          (display integral-ask-pointb)
          (define new-b (eval (read) ns))
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
          (break-pt local-a local-b local-prec))))
  
    (break-pt a b precision))

;; ==============================================================

;; the submenu for curve approximation of a function
;; *can be merged into integral menu
(define (curve-length-application)
  (display curve-length-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display curve-length-ask-pointa)
  (define a (eval (read) ns))
  (display curve-length-ask-pointb)
  (define b (eval (read) ns))
  (display curve-length-ask-prec)
  (define precision (read))
  (cond ((and (procedure? f) (number? a) (number? b) (number? precision))
         (newline)
         (display (curve-length f a b precision)))
        (else
         (display curve-length-inc-func)
         (curve-length-application)))

    (define (break-pt local-a local-b local-prec)
       (display curve-length-ask-msg)
       (define order (read))
       (cond
         ((eq? order '1)
          (display curve-length-ask-pointa)
          (define new-a (eval (read) ns))
          (display curve-length-ask-pointb)
          (define new-b (eval (read) ns))
          (display (curve-length f new-a new-b local-prec))
          (break-pt new-a new-b local-prec))
         ((eq? order '2)
          (display curve-length-ask-prec)
          (define new-precision (read))
          (display (curve-length f local-a local-b new-precision))
          (break-pt local-a local-b new-precision))
         ((eq? order '3)
          (curve-length-application))
         ((eq? order 'q)
          (caltool-main))
         (else
          (display caltool-inc-order)
          (break-pt local-a local-b local-prec))))
  
    (break-pt a b precision))

;; ==============================================================

;; the submenu for building a recursive sequence with one term
(define (recsequence1-application)
  (display recsequence-1-ask-a)
  (define a (eval (read) ns))
  (display recsequence-1-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x k) ~a)" (read)))) ns))
  (cond
    ((and (number? a) (procedure? f))

       (define (break-pt)
          (display recsequence-1-ask-msg)
          (define feature-order (read))
          (cond
            ((eq? feature-order '1)
             (display recsequence-1-1-ask-term)
             (define term (read))
             (display ((recursive-sequence1 a f) term))
             (newline)
             (break-pt))
            ((eq? feature-order '2)
             (display recsequence-1-23-ask-from)
             (define from (read))
             (display recsequence-1-23-ask-to)
             (define to (read))
             (recursive-sequence1-display a f from to)
             (display "")
             (newline)
             (break-pt))
            ((eq? feature-order '3)
             (display recsequence-1-23-ask-from)
             (define from (read))
             (display recsequence-1-23-ask-to)
             (define to (read))
             (define upper (apply + (build-list to (recursive-sequence1 a f))))
             (define lower (apply + (build-list from (recursive-sequence1 a f))))
             (disf "~a - ~a = ~a." upper lower (- upper lower))
             (newline)
             (break-pt))
            ((eq? feature-order '4)
             (recsequence1-application))
            ((eq? feature-order 'q)
             (caltool-main))
            (else
             (display caltool-inc-order)
             (break-pt))))
       
       (break-pt))
    (else
     (display recsequence-1-inc-func)
     (recsequence1-application))))


;; the submenu for building a recursive sequence with two terms
(define (recsequence2-application)
  (display recsequence-2-ask-a)
  (define a (eval (read) ns))
  (display recsequence-2-ask-b)
  (define b (eval (read) ns))
  (display recsequence-2-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x y k) ~a)" (read)))) ns))
  (cond
    ((and (number? a) (number? b) (procedure? f))

       (define (break-pt)
          (display recsequence-2-ask-msg)
          (define feature-order (read))
          (cond
            ((eq? feature-order '1)
             (display recsequence-2-1-ask-term)
             (define term (read))
             (display ((recursive-sequence2 a b f) term))
             (newline)
             (break-pt))
            ((eq? feature-order '2)
             (display recsequence-2-23-ask-from)
             (define from (read))
             (display recsequence-2-23-ask-to)
             (define to (read))
             (recursive-sequence2-display a b f from to)
             (newline)
             (break-pt))
            ((eq? feature-order '3)
             (display recsequence-2-23-ask-from)
             (define from (read))
             (display recsequence-2-23-ask-to)
             (define to (read))
             (define upper (apply + (build-list to (recursive-sequence2 a b f))))
             (define lower (apply + (build-list from (recursive-sequence2 a b f))))
             (disf "~a - ~a = ~a." upper lower (- upper lower))
             (newline)
             (break-pt))
            ((eq? feature-order '4)
             (recsequence2-application))
            ((eq? feature-order 'q)
             (caltool-main))
            (else
             (display caltool-inc-order)
             (break-pt))))
       
       (break-pt))
    (else
     (display recsequence-2-inc-func)
     (recsequence2-application))))

;; ==============================================================

;; the submenu for partial derivative-related calculations

;; the submenu to calculate partial derivatives. this function is accessed through the partial-derivative driver function
;; partial-derivative-application: (Num ... Num -> Num) (Listof Char) -> Void
(define (partial-derivative-application f vars)
  (display partialderivative-partial-ask-point)
  (define point (read))
  (display partialderivative-partial-ask-prec)
  (define prec (read))
  (display partialderivative-partial-ask-var)
  (define var (read))
  (cond
    ((and (list? point) (numberlist? point) (number? prec) (symbol? var))
     (disf "first derivative: ~a" (p-derivative f vars point var prec))
     (disf "\nsecond derivative: ~a" (lr-second-p-derivative f vars point var prec))

       (define (break-pt local-point local-prec local-var)
          (newline)
          (display partialderivative-partial-ask-msg)
          (define order (read))
          (cond
            ((eq? order '1)
             (display partialderivative-partial-ask-point)
             (define new-point (read))
             (disf "first derivative: ~a" (p-derivative f vars new-point local-var local-prec))
             (disf "\nsecond derivative: ~a" (lr-second-p-derivative f vars new-point local-var local-prec))
             (break-pt new-point local-prec local-var))
            ((eq? order '2)
             (display partialderivative-partial-ask-prec)
             (define new-prec (read))
             (disf "first derivative: ~a" (p-derivative f vars local-point local-var new-prec))
             (disf "\nsecond derivative: ~a" (lr-second-p-derivative f vars local-point local-var new-prec))
             (break-pt local-point new-prec local-var))
            ((eq? order '3)
             (display partialderivative-partial-ask-var)
             (define new-var (read))
             (disf "first derivative: ~a" (p-derivative f vars local-point new-var local-prec))
             (disf "\nsecond derivative: ~a" (lr-second-p-derivative f vars local-point new-var local-prec))
             (break-pt local-point local-prec new-var))
            ((eq? order '4)
             (partial-application-select vars f))
            ((eq? order '5)
             (partial-application-enter-intro))
            ((eq? order 'q)
             (caltool-main))
            (else
             (display caltool-inc-order)
             (break-pt local-point local-prec local-var))))
       
       (break-pt point prec var))
    (else
     (display partialderivative-partial-inc-func)
     (partial-derivative-application f vars))))


;; the submenu to calculate gradients. this function is accessed through the partial-derivative driver function
;; partial-gradient-application: (Num ... Num -> Num) (Listof Char) -> Void
(define (partial-gradient-application f vars)
  (display partialderivative-grad-ask-point)
  (define point (read))
  (display partialderivative-grad-ask-prec)
  (define prec (read))
  (cond
    ((and (list? point) (numberlist? point) (number? prec))

       (define (break-pt local-point local-prec)
          (newline)
          (display partialderivative-grad-ask-msg)
          (define order (read))
          (cond
            ((eq? order '1)
             (display partialderivative-grad-ask-point)
             (define new-point (read))
             (display (gradient f vars new-point local-prec))
             (break-pt new-point local-prec))
            ((eq? order '2)
             (display partialderivative-grad-ask-prec)
             (define new-prec (read))
             (display (gradient f vars local-point new-prec))
             (break-pt local-point new-prec))
            ((eq? order '3)
             (partial-application-select vars f))
            ((eq? order '4)
             (partial-application-enter-intro))
            ((eq? order 'q)
             (caltool-main))
            (else
             (display caltool-inc-order)
             (break-pt local-point local-prec))))
       
       (display (gradient f vars point prec))
       (break-pt point prec))
    (else
     (display partialderivative-grad-inc-func)
     (partial-gradient-application f vars))))


;; the submenu to calculate directional derivatives. this function is accessed through the partial-derivative driver function
;; partial-direction-application: (Num ... Num -> Num) (Listof Char) -> Void
(define (partial-direction-application f vars)
  (display partialderivative-dir-ask-point)
  (define point (read))
  (display partialderivative-dir-ask-prec)
  (define prec (read))
  (display partialderivative-dir-ask-dir)
  (define dir (map degrees->radians (read)))
  (cond
    ((and (list? point) (numberlist? point) (number? prec)
          (list? dir) (numberlist? dir))

       (define (break-pt local-point local-prec local-dir)
          (newline)
          (display partialderivative-dir-ask-msg)
          (define order (read))
          (cond
            ((eq? order '1)
             (display partialderivative-dir-ask-point)
             (define new-point (read))
             (display (directional-derivative f vars new-point local-dir local-prec))
             (break-pt new-point local-prec local-dir))
            ((eq? order '2)
             (display partialderivative-dir-ask-prec)
             (define new-prec (read))
             (display (directional-derivative f vars local-point local-dir new-prec))
             (break-pt local-point new-prec local-dir))
            ((eq? order '3)
             (display partialderivative-dir-ask-dir)
             (define new-dir (map degrees->radians (read)))
             (display (directional-derivative f vars local-point new-dir local-prec))
             (break-pt local-point local-prec new-dir))
            ((eq? order '4)
             (partial-application-select vars f))
            ((eq? order '5)
             (partial-application-enter-intro))
            ((eq? order 'q)
             (caltool-main))
            (else
             (display caltool-inc-order)
             (break-pt local-point local-prec local-dir))))
       
       (display (directional-derivative f vars point dir prec))
       (break-pt point prec dir))
    (else
     (display partialderivative-dir-inc-func)
     (partial-direction-application f vars))))


;; the driver of partial derivative features. function and variable list are created here and then
;; passed to the select function
(define (partial-application-enter-intro)
  (display partialderivative-ask-vars)
  (define vars (read))
  (display partialderivative-ask-func)
  (define f (eval (read (open-input-string (format "(lambda ~a ~a)" vars (read)))) ns))
  (cond
    ((and (list? vars) (procedure? f))
     (partial-application-select vars f))
    (else
     (display partialderivative-partial-inc-func)
     (partial-application-enter-intro))))

;; the selection menu. will call each feature function to complete calculations
;; partial-application-select: (Num ... Num -> Num) (Listof Char) -> Void
(define (partial-application-select vars f)
  (display partialderivative-ask-feature)
  (define par-order (read))
  (cond
    ((eq? par-order '1)
     (partial-derivative-application f vars))
    ((eq? par-order '2)
     (partial-gradient-application f vars))
    ((eq? par-order '3)
     (partial-direction-application f vars))
    ((eq? par-order 'q)
     (caltool-main))
    (else
     (display caltool-inc-order)
     (partial-application-select vars f))))


;; ==============================================================

;; the submenu for left and right derivatives
(define (derivative/lr-application)
  (display derivative-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display derivative-ask-point)
  (define point (eval (read) ns))
  (display derivative-ask-prec)
  (define precision (read))
  (cond ((and (procedure? f) (number? point) (number? precision))
         (newline)
         (disf "L: ~a\n" (left-derivative f point precision))
         (disf "R: ~a" (right-derivative f point precision))
         (newline)
         (display calextra-toreturn)
         (define order (read))
         (cond
     ;      ((eq? order 'q) ; not implremented yet. all actions except entering 1 result in quitting
     ;       (caltool-main))
           ((eq? order '1)
            (derivative/lr-application))
           (else
            (caltool-main))))
        (else
         (display derivative-inc-func)
         (derivative/lr-application))))

;; ==============================================================

;; the submenu for left and right definite integrals
(define (integral/lr-application)
  (display integral-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display integral-ask-pointa)
  (define a (eval (read) ns))
  (display integral-ask-pointb)
  (define b (eval (read) ns))
  (display integral-ask-prec)
  (define precision (read))
  (cond ((and (procedure? f) (number? a) (number? b) (number? precision))
         (newline)
         (disf "L: ~a\n" (area-fx-rectangular-left f a b precision))
         (disf "R: ~a" (area-fx-rectangular-right f a b precision))
         (newline)
         (display calextra-toreturn)
         (define order (read))
         (cond
      ;     ((eq? order 'q)
      ;      (caltool-main))
           ((eq? order '1)
            (integral/lr-application))
           (else
            (caltool-main))))
        (else
         (display integral-inc-func)
         (integral/lr-application))))

;; ==============================================================

;; the submenu for summing closed forms
(define (sigma-application)
  (display recsequence-1-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display recsequence-1-23-ask-from)
  (define from (read))
  (display recsequence-1-23-ask-to)
  (define to (read))
  (cond ((and (procedure? f) (natural? from) (natural? to))
         (newline)
         (disf "~a - ~a = ~a" (sigma f to) (sigma f from)
                 (- (sigma f to) (sigma f from)))
         (newline)
         (display calextra-toreturn)
         (define order (read))
         (cond
       ;    ((eq? order 'q)
       ;     (caltool-main))
           ((eq? order '1)
            (sigma-application))
           (else
            (caltool-main))))
        (else
         (display recsequence-1-inc-func)
         (sigma-application))))

;; ==============================================================

;; the submenu for multiplying closed forms
(define (bigpi-application)
  (display recsequence-1-ask-func)
  (define f (eval (read (open-input-string (format "(lambda (x) ~a)" (read)))) ns))
  (display recsequence-1-23-ask-from)
  (define from (read))
  (display recsequence-1-23-ask-to)
  (define to (read))
  (cond ((and (procedure? f) (natural? from) (natural? to))
         (newline)
         (disf "~a / ~a = ~a" (bigpi f to) (bigpi f from)
                 (/ (bigpi f to) (bigpi f from)))
         (newline)
         (display calextra-toreturn)
         (define order (read))
         (cond
      ;     ((eq? order 'q)
      ;      (caltool-main))
           ((eq? order '1)
            (bigpi-application))
           (else
            (caltool-main))))
        (else
         (display recsequence-1-inc-func)
         (bigpi-application))))

;; ==============================================================

;; the submenu for conversion bewtwwen decimal and other bases
;; contains a selection menu: splits into two features
(define (basen-application)
  (display calextra-basen-ask-msg)
  (define basn-order (read))
  (cond
    ((eq? basn-order '1)
     (display calextra-basen-ask-base)
     (define base (read))
     (display calextra-basen-ask-num)
     (define num (read))
     (cond
       ((and (number? base) (number? num) (> base 1) (positive? num))
        (newline)
        (display (dec->basen base num))
        (newline)
        (display calextra-basen-ask-next)
        (define order (read))
        (cond
          ((eq? order '1)
           (basen-application))
          (else
           (caltool-main))))
       (else
        (display calextra-basen-inc)
        (basen-application))))
    ((eq? basn-order '2)
     (display calextra-basen-ask-base)
     (define base (read))
     (display calextra-basen-ask-num)
     (define num (read))
     (cond
       ((and (number? base) (number? num) (positive? base) (positive? num) (<= base 10))
        (newline)
        (display (basen->dec base num))
        (newline)
        (display calextra-basen-ask-next)
        (define order (read))
        (cond
          ((eq? order '1)
           (basen-application))
          (else
           (caltool-main))))
       (else
        (display calextra-basen-inc)
        (basen-application))))
    (else
     (display caltool-inc-order)
     (basen-application))))
        
;; ==============================================================

;; the submenu for using extended Euclidean algorithm
(define (eea-application)
  (display calextra-eea-ask-1st)
  (define a (read))
  (display calextra-eea-ask-2nd)
  (define b (read))
  (cond ((and (integer? a) (integer? b))
         (gen-eea a b)
         (newline)
         (display calextra-eea-ask-next)
         (define order (read))
         (cond ((eq? order '1)
                (eea-application))
               ((eq? order 'q)
                (caltool-main))
               (else
                (caltool-main))))
        (else
         (display calextra-eea-inc)
         (eea-application))))

;; ==============================================================

;; the submenu for magnitude of a vector
(define (magnitude-application)
  (display mag-ask-vec)
  (define u (read))
  (cond ((and (list? u) (numberlist? u))
         (newline)
         (display (vec-mag u)))
        (else
         (display mag-inc-vec)
         (magnitude-application)))

    (define (break-pt)
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
              (break-pt))))
  
    (break-pt))

;; ==============================================================

;; the submenu for dot and cross products of vectors
(define (product-application)
  (display product-ask-vec1)
  (define u (read))
  (display product-ask-vec2)
  (define v (read))
  (cond ((and (list? u) (numberlist? u) (list? v) (numberlist? v)
              (eq? (length u) (length v)))
         (newline)
         (cond
           ((eq? (length u) 3)
            (disf "inner product: ~a\n" (vec-dot u v))
            (disf "cross product: ~a" (vec-cross u v)))
           (else
            (display (vec-dot u v))))
         (newline)
         (display product-ask-msg)
         (define order (read))
         (cond
           ((eq? order '1)
            (product-application))
    ;       ((eq? order 'q)
    ;          (caltool-main))
           (else
            (display caltool-inc-order)
            (caltool-main))))
        (else
         (display product-inc-vec)
         (product-application))))

;; ==============================================================

;; the submenu for projections of a vector
(define (projection-application)
  (display projection-ask-vec1)
  (define x (read))
  (display projection-ask-vec2)
  (define u (read))
  (cond ((and (list? x) (numberlist? x) (list? u) (numberlist? u)
              (eq? (length x) (length u)))
         (newline)
         (display (proj u x)) (newline)
         (display (perp u x)) (newline)
         (display (refl u x))
         (newline)
         (display product-ask-msg)
         (define order (read))
         (cond
           ((eq? order '1)
            (projection-application))
      ;     ((eq? order 'q)
      ;        (caltool-main))
           (else
            (display caltool-inc-order)
            (caltool-main))))
        (else
         (display projection-inc-vec)
         (projection-application))))

;; ==============================================================

;; the submenu for rotating a 2d vector
(define (rotation2d-application)
  (display rotation2d-ask-vec)
  (define u (read))
  (display rotation2d-ask-angle)
  (define a (degrees->radians (read)))
  (cond ((and (list? u) (numberlist? u) (number? a)
              (eq? (length u) 2))
         (newline)
         (display (map (lambda (x) (round-off x 6)) (r2 u a)))
         (newline)
         (display rotation2d-ask-msg)
         (define order (read))
         (cond
           ((eq? order '1)
            (rotation2d-application))
      ;     ((eq? order 'q)
      ;        (caltool-main))
           (else
            (display caltool-inc-order)
            (caltool-main))))
        (else
         (display rotation2d-inc-vec)
         (rotation2d-application))))























