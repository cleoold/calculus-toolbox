#lang scheme

(provide (all-defined-out))

(define caltool-intro-msg
  (string-append
   "         *    *    *    *    *    *    *          "
   "\n"
   "         *    *    *    *    *    *    *          "
   "\n"
   "welcome to my rough math toolbox for (very limited amout of) calculations in calculus. "
   "\n"
   "this executive effeciently calculates common questions such as finding derivatives, "
   "solving equations, building recurrence sequences and more."
   "\n"
   "there are memorisation features implemented in this tool. information from your last input will be used"
   " if more than one arguments are required."
   "\n" "\n"
   "the tool is written in scheme language. when typing the representation of a function, "
   "you need to use the correct syntax as determined by the language so that it is readable. "
   "for example, `(sin (- x 1))` represents sin(x - 1). "
   "\n"
   "to type a vector, simply hit something like `(1 -2 3)`. for matrices, type `((1 -2 3)(1 -2 3)(1 -2 3))`."
   "\n" "\n"
   "this tool is written by cos. please refer to page github.com/cleoold/calculus-toolbox "
   " for the source code of this programme as well as their mathematical principles."
   "\n" "\n"
   "         *    *    *    *    *    *    *          "
   "\n"))

(define caltool-select-main
  (string-append
   "what do you want to do?" "\n"
   "1-calculus. 2-vectors. q-exit." "\n" "\n"
   "to give command, put your number and hit enter." "\n"))

(define caltool-select-cal
  (string-append
   "select your feature" "\n"
   "1-solve equation. 2-derivative. 3-integral." "\n" "\n"))

(define caltool-select-vec
  (string-append
   "select your feature" "\n"
   "1-magnitude" "\n" "\n"))

(define caltool-inc-order
  "that is not a valid order.\n \n")

;; ==============================================================

(define newtonsolve-intro-msg
  (string-append
   "================================================================================="
   "\n"
   "this tool operates the calculation of finding the roots to the equation y=f(x)=0 by Newton's method."
   "\n"
   "notice this tool accepts the complete scheme code of the function y=f(x) by defining it by operator "
   "functions (like + - * / expt cos etc.) be sure to include the variable x, or the program will exit."
   "\n"
   "for example, by typing `(- (cos x) (* 2 x))` one can find the root to the equation cos(x) - 2x = 0."
   "\n" "\n"
   "the tool provides custom options such as precision (for derivative calculating) and number of recursive calls. "
   "but a number that is too small ie (expt 0.1 -20) does not guarantee the precision. the result might look weird "
   "or very incorrect. so an appriopriate precision is important."
   "\n"
   "also notice some functions don't work by Newton's method. under this situation the programme might not terminate."
   " you have to close the window manually."
   "\n" "\n"))

(define newtonsolve-ask-func
  "please enter your function.\n")
(define newtonsolve-ask-guess
  "enter your initial guess.\n")
(define newtonsolve-ask-prec
  "enter your desired precision.\n")
(define newtonsolve-ask-recur
  "how many times do you want the procedure to recur?\n")

(define newtonsolve-ask-msg
  (string-append
   "\n" "\n"
   "what do you want to do next?" "\n"
   "1-change guess. 2-change precision. 3-change recurrence. 4-new function." "\n"
   "q-return." "\n"))

(define newtonsolve-inc-func
  "make sure you typed in the correct format.\n \n")

;; ==============================================================

(define derivative-intro-msg
  (string-append
   "================================================================================="
   "\n"
   "to input your function, use the full syntax such as `(- (cos x) (* 2 x))`, which represents f(x) = cos(x) - 2x."
   "\n"
   "to input the point, simply type the number of x axis." "\n" "\n"))

(define derivative-ask-func
  "please enter your function.\n")

(define derivative-ask-point
  "please enter your point.\n")

(define derivative-ask-prec
  "enter your desired precision.\n")

(define derivative-ask-msg
  (string-append
   "\n" "\n"
   "what do you want to do next?" "\n"
   "1-change point. 2-change precision. 3-new function." "\n"
   "q-return." "\n"))

(define derivative-inc-func
  "make sure you typed in the correct format.\n \n")
  
;; ==============================================================

(define integral-intro-msg
  (string-append
   "================================================================================="
   "\n"
   "to input your function, use the full syntax such as `(- (cos x) (* 2 x))`, which represents f(x) = cos(x) - 2x."
   "\n"
   "avoid precision that is too small. the programme may run out of memory."
   "\n"
   "this tool has certain limitations. since it uses the averages of the values on the two sides of subintervals "
   "to calculate the total partition, it might not detect divergent integrals that don't have values. in this case, "
   "please adjust precision (size of ||P||) to see if the result is consistent."
   "\n"
   "to input the point, simply type the number of x axis." "\n" "\n"))

(define integral-ask-func
  "please enter your function.\n")

(define integral-ask-pointa
  "from which point?\n")

(define integral-ask-pointb
  "to which point?\n")

(define integral-ask-prec
  "enter your desired precision.\n")

(define integral-ask-msg
  (string-append
   "\n" "\n"
   "what do you want to do next?" "\n"
   "1-change bounds. 2-change precision. 3-new function." "\n"
   "q-return." "\n"))

(define integral-inc-func
  "make sure you typed in the correct format.\n \n")

;; ==============================================================






;; ==============================================================

(define mag-intro-msg
    (string-append
   "================================================================================="
   "\n"
   "this evaluates the magnitude of a vector, for example, ||(3 4)|| = 5." "\n" "\n"))

(define mag-ask-vec
  "please enter your vector.\n")

(define mag-ask-msg
  (string-append
   "\n" "\n"
   "what do you want to do next?" "\n"
   "1-change vector. q-return." "\n"))

(define mag-inc-vec
  "make sure you typed in the correct format.\n \n")

























