#lang scheme/base

(provide (all-defined-out))

(define caltool-intro-msg
  (string-append
   "           *    *    *    *    *    *    *          "
   "\n"
   "           *    *    *    *    *    *    *          "
   "\n"
   "  welcome to my rough math toolbox for (very limited amout of) calculations in calculus. "
   "\n"
   "  this executive effeciently calculates common questions such as finding derivatives, "
   "solving equations, building recurrence sequences and more."
   "\n"
   "  there are memorisation features implemented in this tool. information from your last input will be used "
   "if more than one arguments are required, unless you hit `q` to return."
   "\n" "\n"
   "  the tool is written in scheme language. when typing the representation of a function, "
   "you need to use the correct syntax as determined by the language so that it is readable. "
   "\n" "\n"
   "  for example, `(sin (- x 1))` represents sin(x - 1). "
   "\n" "\n"
   "  to type a vector, simply hit something like `(1 -2 3)`. for matrices, type `((1 -2 3)(1 -2 3)(1 -2 3))`."
   "\n" "\n"
   "  this tool is written by cos. you can refer to page github.com/cleoold/calculus-toolbox "
   "for the source code of this programme and I will keep adding more features."
   "\n"
   "  you can now enter q to see a list of function convention examples. "
   "\n" "\n"
   "           *    *    *    *    *    *    *          "
   "\n"))

(define caltool-select-main
  (string-append
   "        == MAIN PAGE ===       \n"
   "  what do you want to do?" "\n"
   "  1-calculus. 2-vectors."
   "\n"
   "  q-exit." "\n" "\n"
   "  to give command, put your number and hit enter." "\n"))

(define caltool-select-cal
  (string-append
   "  select your feature" "\n"
   "  1-solve equation. 2-derivative. 3-integral. 4-recurrence sequence.\n"
   "  5-multivariable derivative. 0-additional. " "\n" "\n"))

(define caltool-select-vec
  (string-append
   "  select your feature" "\n"
   "  1-magnitude. 2-product. 3-projection. 4-rotation(2D)." "\n" "\n"))

(define caltool-inc-order
  "  that is not a valid order.\n \n")

;; ==============================================================

(define newtonsolve-intro-msg
  (string-append
   "  ================================================================================="
   "\n"
   "  this tool operates the calculation of finding the roots to the equation y=f(x)=0 by Newton's method."
   "\n"
   "  notice this tool accepts the complete scheme code of the function y=f(x) by defining it by operator "
   "functions (like + - * / expt cos etc.) be sure to include the variable x, or the program will exit."
   "\n"
   "  for example, by typing `(- (cos x) (* 2 x))` one can find the root to the equation cos(x) - 2x = 0."
   "\n" "\n"
   "  the tool provides custom options such as precision (for derivative calculating) and number of recursive calls. "
   "but a number that is too small ie (expt 0.1 -20) does not guarantee the precision. the result might look weird "
   "or very incorrect. so an appriopriate precision is important."
   "\n"
   "  also notice some functions don't work by Newton's method. under this situation the programme might not terminate."
   "you have to close the window manually."
   "\n" "\n"))

(define newtonsolve-ask-func
  "  please enter your function.\n")
(define newtonsolve-ask-guess
  "  enter your initial guess.\n")
(define newtonsolve-ask-prec
  "  enter your desired precision.\n")
(define newtonsolve-ask-recur
  "  how many times do you want the procedure to recur?\n")

(define newtonsolve-ask-msg
  (string-append
   "\n" "\n"
   "  what do you want to do next?" "\n"
   "  1-change guess. 2-change precision. 3-change recurrence. 4-new function." "\n"
   " q-return." "\n"))

(define newtonsolve-inc-func
  "  make sure you typed in the correct format.\n \n")

;; ==============================================================

(define derivative-intro-msg
  (string-append
   "  ================================================================================="
   "\n"
   "  to input your function, use the full syntax such as `(- (cos x) (* 2 x))`, which represents f(x) = cos(x) - 2x."
   "\n"
   "  to input the point, simply type the number of x axis. also, please stick with the variable `x`." "\n" "\n"))

(define derivative-ask-func
  "  please enter your function.\n")

(define derivative-ask-point
  "  please enter your point.\n")

(define derivative-ask-prec
  "  enter your desired precision.\n")

(define derivative-ask-msg
  (string-append
   "\n" "\n"
   "  what do you want to do next?" "\n"
   "  1-change point. 2-change precision. 3-new function." "\n"
   "  q-return." "\n"))

(define derivative-inc-func
  "  make sure you typed in the correct format.\n \n")
  
;; ==============================================================

(define integral-intro-msg
  (string-append
   "  ================================================================================="
   "\n"
   "  to input your function, use the full syntax such as `(- (cos x) (* 2 x))`, which represents f(x) = cos(x) - 2x."
   "\n"
   "  avoid precision that is too small. the programme may run out of your memory."
   "\n"
   "  this tool has certain limitations. since it uses the averages of the values on the two sides of subintervals "
   "to calculate the total partition, it might not detect divergent integrals that don't have values. in this case, "
   "please adjust precision (size of ||P||) to see if the result is consistent."
   "\n"
   "  to input the point, simply type the number of x axis. also, please stick with the variable `x`. " "\n" "\n"))

(define integral-ask-func
  "  please enter your function.\n")

(define integral-ask-pointa
  "  from which point?\n")

(define integral-ask-pointb
  "  to which point?\n")

(define integral-ask-prec
  "  enter your desired precision.\n")

(define integral-ask-msg
  (string-append
   "\n" "\n"
   "  what do you want to do next?" "\n"
   "  1-change bounds. 2-change precision. 3-new function." "\n"
   "  q-return." "\n"))

(define integral-inc-func
  "  make sure you typed in the correct format.\n \n")

;; ==============================================================

(define recsequence-main-intro-msg
  (string-append
   "  ================================================================================="
   "\n"
   "  this tool automatically computes terms of sequences that aren't defined in closed forms. you can refer to one "
   "specific term or a list of entries from index k=a to a another index k=b. to define a recurrence sequence in this tool, "
   "like functions, you also need to use the correct syntax."
   "\n"
   "  please read carefully the following rules: "
   "\n" "\n"
   "  a one-term-recursive sequence defines its value based on its previous term, given the first term. such expressions look like "
   "\n"
   "      a(0) = A, \n"
   "      a(1) = f[a(0)],\n"
   "      a(2) = f[a(1)],\n"
   "      ...,\n"
   "      a(k) = f[a(k-1)], where f is a function that defines values recursively. "
   "\n"
   "  for example, if you want to compute the sequence {a(0) = 1, a(k) = 2 * a(k-1)}, you need to input `1` for A, and `(* 2 x)` for the "
   "function. this yields a geometric sequence of ratio 2. BE SURE to include `x` to represent your previous term. "
   "\n"
   "  if this is what you want, enter 1. "
   "\n" "\n"
   "  a two-term-recursive sequence is similar, but defines its next value by the previous two terms. they look like "
   "\n"
   "      a(0) = A,\n"
   "      a(1) = B,\n"
   "      a(2) = f[a(0), a(1)],\n"
   "      ...,\n"
   "      a(k) = f[a(k-2), a(k-1)]. "
   "\n"
   "  for example, if you want to compute {a(0) = 1, a(1) = 1, a(k) = a(k-2) + a(k-1)}, type `1` for A, `1` for B, and `(+ x y)` for the "
   "function. this produces a fibonacci sequence. also be sure to include `x` for the second-previous term, and `y` for previous term. "
   "\n"
   "  if this is what you want, enter 2. "
   "\n"
   "\n"
   "  also acknowledge the sequence starts with index 0, which means 0 implies the first term. and 0 ~ 4 means 1st, 2nd, 3rd, 4nd terms, "
   "not including the fifth, so 4 terms in total. other indices follow. "
   "\n" "\n"))

(define recsequence-main-select
  "  please enter your order.\n")


;; ==================

(define recsequence-1-ask-a
  "  please enter your A, this is the first term.\n")

(define recsequence-1-ask-func
  "  please define your sequence.\n")

;(define recsequence-1-ask-feature
;  "  1-for a specific term. 2-build between two indices. 3-sum between two indices.\n")

(define recsequence-1-1-ask-term
  "  which index?\n")

(define recsequence-1-23-ask-from
  "  from which index?\n")

(define recsequence-1-23-ask-to
  "  to which index?\n")

(define recsequence-1-ask-msg
  (string-append
   "\n"
   "  what do you want to do next?" "\n"
   "  1-for a specific term. 2-build between two indices. 3-sum between two indices. 4-new sequence." "\n"
   "  q-return." "\n"))

(define recsequence-1-inc-func
  "  make sure you typed in the correct format. \n \n")

;; ==================

(define recsequence-2-ask-a
  "  please enter your A, this is the first term.\n")

(define recsequence-2-ask-b
  "  please enter your B, this is the second term.\n")

(define recsequence-2-ask-func
  "  please define your sequence.\n")

;(define recsequence-2-ask-feature
;  "  1-for a specific term. 2-build between two indices. 3-sum between two indices.\n")

(define recsequence-2-1-ask-term
  "  which term?\n")

(define recsequence-2-23-ask-from
  "  from which index?\n")

(define recsequence-2-23-ask-to
  "  to which index?\n")

(define recsequence-2-ask-msg
  (string-append
   "\n"
   "  what do you want to do next?" "\n"
   "  1-for a specific term. 2-build between two indices. 3-sum between two indices. 4-new sequence." "\n"
   "  q-return." "\n"))

(define recsequence-2-inc-func
  "  make sure you typed in the correct format. \n \n")


;; ==============================================================

(define partialderivative-main-intro-msg
  (string-append
   "  ================================================================================="
   "\n"
   "  this menu provides further calculations related to derivatives in multivariable calculus. theorectically, "
   "it supports functions with infinite dimensions since the computation is as simple as in single variable. "
   "\n" "\n"
   "to type a function, for example, s = f(x,y,z,t) = cos(xt - zy + pi), you need to declare the variables in "
   "the first box, in this case `(x y z t)`, then type the function `(cos (+ (* x t) (* -1 z y) pi))`.\n"
   "  to enter the point, type them like vectors, but make sure the length match the number of variables. "
   "(in fact, that `(x y z t)` is a vector as well)"
   "\n" "\n"))

(define partialderivative-ask-vars
  "  enter your variables. they should be enclosed in a pair of brackets, seperated by space.\n")

(define partialderivative-ask-func
  "  please enter your function.\n")

(define partialderivative-ask-feature
  (string-append
   "\n"
   "  what do you want to do next?" "\n"
   "  1-partial derivative. 2-gradient. 3-directional derivative." "\n"
   "  q-return." "\n"))

;; ==================

(define partialderivative-partial-ask-point
  "  please enter your point.\n")

(define partialderivative-partial-ask-prec
  "  please enter your desired precision.\n")

(define partialderivative-partial-ask-var
  "  whith respect to which variable? don't include the bracket.\n")

(define partialderivative-partial-ask-msg
  (string-append
   "\n"
   "  what do you want to do next?" "\n"
   "  1-change point. 2-change precision. 3-change variable. 4-other features. 5-new function." "\n"
   "  q-return." "\n"))

(define partialderivative-partial-inc-func
  "  make sure you typed in the correct format. \n \n")

;; ==================

(define partialderivative-grad-ask-point
  "  please enter your point.\n")

(define partialderivative-grad-ask-prec
  "  please enter your desired precision.\n")

(define partialderivative-grad-ask-msg
  (string-append
   "\n"
   "  what do you want to do next?" "\n"
   "  1-change point. 2-change precision. 3-other features. 4-new function." "\n"
   "  q-return." "\n"))

(define partialderivative-grad-inc-func
  "  make sure you typed in the correct format. \n \n")

;; ==================

(define partialderivative-dir-ask-point
  "  please enter your point.\n")

(define partialderivative-dir-ask-prec
  "  please enter your desired precision.\n")

(define partialderivative-dir-ask-dir
  "  enter your direction vector in degrees.\n")

(define partialderivative-dir-ask-msg
  (string-append
   "\n"
   "  what do you want to do next?" "\n"
   "  1-change point. 2-change precision. 3-change direction. 4-other features. 5-new function." "\n"
   "  q-return." "\n"))

(define partialderivative-dir-inc-func
  "  make sure you typed in the correct format. \n \n")


;; ==============================================================

(define calcextra-intro-msg
  (string-append
   "  select your feature."
   "\n"
   " 1-left/right derivative. 2-left/right integral. 3-SIGMA. 4-PI. 5-baseN converter."
   "\n" "\n"))

(define calextra-derivative-intro-msg
  (string-append
   "  ================================================================================="
   "\n"
   "  the toolkit uses right derivative in other features, but you can also choose to calculate the "
   "left derivative of the function f(x). the left derivative will appear on the top, followed by the "
   "right derivative."
   "\n" "\n"))

(define calextra-integral-intro-msg
  (string-append
   "  ================================================================================="
   "\n"
   "  you can calculate both left and right Riemann sums to check results. if the program crashes, "
   "it's not integrable."
   "\n" "\n"))

(define calextra-sigma-intro-msg
  (string-append
   "  ================================================================================="
   "\n"
   "  if your sequence is in the closed form, you can acquire its partial sum from one index to another index. "
   "indexes start from zero, if you want your sequence start from 1, replace every of your `x` by `(add1 x)`. this "
   "increments x by one."
   "\n" "\n"))

(define calextra-pi-intro-msg
  (string-append
   "  ================================================================================="
   "\n"
   "  if your sequence is in the closed form, you can acquire its partial product from one index to another index. "
   "indexes start from zero, if you want your sequence start from 1, replace every of your `x` by `(add1 x)`. this "
   "increments x by one."
   "\n" "\n"))

(define calextra-toreturn
  " \n 1-new function. q-return.\n")

(define calextra-basen-ask-msg
  (string-append
   "  ================================================================================="
   "\n"
   " select your feature."
   "\n"
   "  1-decimal to base n. 2-base n to decimal."
   "\n" "\n"))

(define calextra-basen-ask-base
  "  which base?\n")

(define calextra-basen-ask-num
  "  enter your number.\n")

(define calextra-basen-ask-next
  "  1-another conversion. q-return.\n")

(define calextra-basen-inc
  "  check syntax.\n")


;; ==============================================================

(define mag-intro-msg
    (string-append
   "  ================================================================================="
   "\n"
   "  this evaluates the magnitude of a vector, for example, ||(3 4)|| = 5." "\n" "\n"))

(define mag-ask-vec
  "  please enter your vector.\n")

(define mag-ask-msg
  (string-append
   "\n" "\n"
   "  what do you want to do next?" "\n"
   "  1-change vector. q-return." "\n"))

(define mag-inc-vec
  "  make sure you typed in the correct format.\n \n")

;; ==============================================================

(define product-intro-msg
    (string-append
   "  ================================================================================="
   "\n"
   "  this tool computes the inner product of two vectors. if the lengths of two vectors "
   "are 3, then their cross product u * v will then be computed."
   "\n" "\n"))

(define product-ask-vec1
  "  please enter your first vector u.\n")

(define product-ask-vec2
  "  please enter your second vector v.\n")

(define product-ask-msg
  (string-append
   "\n" "\n"
   "  what do you want to do next?" "\n"
   "  1-change vectors. q-return." "\n"))

(define product-inc-vec
  "  make sure you typed in the correct format.\n \n")

;; ==============================================================

(define projection-intro-msg
    (string-append
   "  ================================================================================="
   "\n"
   "  enter your two vectors x and u, the following will be computed in order:\n"
   "  1. projection of vector x onto vector u.\n"
   "  1. perpendicular of vector x onto vector u.\n"
   "  1. reflection of vector x onto the hyperplane with normal u.\n"
   "\n"))

(define projection-ask-vec1
  "  please enter vector x.\n")

(define projection-ask-vec2
  "  please enter vector u.\n")

(define projection-ask-msg
  (string-append
   "\n" "\n"
   "  what do you want to do next?" "\n"
   "  1-change vectors. q-return." "\n"))

(define projection-inc-vec
  "  make sure you typed in the correct format.\n \n")

;; ==============================================================

(define rotation2d-intro-msg
    (string-append
   "  ================================================================================="
   "\n"
   "  using the rotation matrix to rotate the vector in 2D.\n"
   "\n"))

(define rotation2d-ask-vec
  "  please enter your vector.\n")

(define rotation2d-ask-angle
  "  please enter your angle in degrees.\n")

(define rotation2d-ask-msg
  (string-append
   "\n" "\n"
   "  what do you want to do next?" "\n"
   "  1-change vector. q-return." "\n"))

(define rotation2d-inc-vec
  "  make sure you typed in the correct format.\n \n")






(define intro-convention
  (string-append
   "      below lists some expression convention examples from typing (left) to scheme (right)."
   "\n" "\n"
   "     x + 7  =>  (+ x 7)\n"
   "     x * 1.6  =>  (* x 1.6)\n"
   "     5 - 2  =>  (- 5 2) or (+ 5 (- 2))\n"
   "     pi / 3.14  =>  (/ pi 3)\n"
   "     e = e^1  =>  (exp 1)\n"
   "     x^(1/2)  =>  (expt x 1/2) or (sqrt x)\n"
   "     cos(x)  =>  (cos x)\n"
   "\n"
   "     tan[atan(x)]  =>  (tan (atan x))\n"
   "     floor[cosh(3x+1)]  =>  (floor (cosh (+ (* 3 x) 1)))\n"
   "     asin[sqrt(x^2-1)]  =>  (asin (sqrt (- (expt x 2) 1)))\n"
   "\n"
   "     2log(1/x) - y  =>  (- (* 2 (log (/ 1 x))) y)\n"
   "     1.4cos(pi*x-4.5t+6)  =>  (* 1.4 (cos (+ (* pi x) (* -4.5 t) 6)))\n"
   "     x^8 + y^(- 2)  => (+ (expt x 8) (expt y -2))\n"
   "\n"
   "     [2,3,-2,4]  =>  (2 3 -2 4)\n"
   "     [x,y,z]  =>  (x y z)\n"
   "     visit scheme/racket documentation for more info."
   "\n"
   "\n" "\n" "\n"))
   













