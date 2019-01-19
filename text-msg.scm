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
   "  solving equations, building recurrence sequences and more."
   "\n"
   "  there are memorisation features implemented in this tool. information from your last input will be used"
   "   if more than one arguments are required, unless you hit `q` to return."
   "\n" "\n"
   "  the tool is written in scheme language. when typing the representation of a function, "
   "  you need to use the correct syntax as determined by the language so that it is readable. "
   "\n" "\n"
   "  for example, `(sin (- x 1))` represents sin(x - 1). "
   "\n" "\n"
   "  to type a vector, simply hit something like `(1 -2 3)`. for matrices, type `((1 -2 3)(1 -2 3)(1 -2 3))`."
   "\n" "\n"
   "  this tool is written by cos. please refer to page github.com/cleoold/calculus-toolbox "
   "   for the source code of this programme as well as their mathematical principles."
   "\n" "\n"
   "           *    *    *    *    *    *    *          "
   "\n"))

(define caltool-select-main
  (string-append
   "  what do you want to do?" "\n"
   "  1-calculus. 2-vectors. q-exit." "\n" "\n"
   "  to give command, put your number and hit enter." "\n"))

(define caltool-select-cal
  (string-append
   "  select your feature" "\n"
   "  1-solve equation. 2-derivative. 3-integral. 4-recurrence sequence." "\n" "\n"))

(define caltool-select-vec
  (string-append
   "  select your feature" "\n"
   "  1-magnitude" "\n" "\n"))

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
   "  functions (like + - * / expt cos etc.) be sure to include the variable x, or the program will exit."
   "\n"
   "  for example, by typing `(- (cos x) (* 2 x))` one can find the root to the equation cos(x) - 2x = 0."
   "\n" "\n"
   "  the tool provides custom options such as precision (for derivative calculating) and number of recursive calls. "
   "  but a number that is too small ie (expt 0.1 -20) does not guarantee the precision. the result might look weird "
   "  or very incorrect. so an appriopriate precision is important."
   "\n"
   "  also notice some functions don't work by Newton's method. under this situation the programme might not terminate."
   "   you have to close the window manually."
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
   "  to calculate the total partition, it might not detect divergent integrals that don't have values. in this case, "
   "  please adjust precision (size of ||P||) to see if the result is consistent."
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
   "  a(0) = A, a(1) = f[a(0)], a(2) = f[a(1)], ..., a(k) = f[a(k-1)], where f is a function that defines values recursively. "
   "\n"
   "  for example, if you want to compute the sequence {a(0) = 1, a(k) = 2 * a(k-1)}, you need to input `1` for A, and `(* 2 x)` for the "
   "function. this yields a geometric sequence of ratio 2. BE SURE to include `x` to represent your previous term. "
   "\n"
   "  if this is what you want, enter 1. "
   "\n" "\n"
   "  a two-term-recursive sequence is similar, but defines its next value by the previous two terms. they look like "
   "\n"
   " a(0) = A, a(1) = B, a(2) = f[a(0), a(1)], ..., a(k) = f[a(k-2), a(k-1)]. "
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
   "\n" "\n"
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
   "\n" "\n"
   "  what do you want to do next?" "\n"
   "  1-for a specific term. 2-build between two indices. 3-sum between two indices. 4-new sequence." "\n"
   "  q-return." "\n"))

(define recsequence-2-inc-func
  "  make sure you typed in the correct format. \n \n")




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

























