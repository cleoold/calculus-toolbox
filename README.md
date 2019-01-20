# Calculus toolbox provides some easy computations related to math

With this tool, you can do math and engineering calculations, such as integrals, recurrence sequences and vectors, more easily.
All you need to do are to stick with some function syntax in Scheme (like using brackets `()`) to enter formulas, and put integers
to select things in my menu.  
  
The repository containing the source codes is located [page](github.com/cleoold/calculus-toolbox). The programme is written in Scheme, you can
open the file `runme.scm` in the main folder in `Drracket` to run it (as it includes `#lang scheme` prefix). If you are using a different 
interpreter or compiler, you might need the corresponding module and commit out that `#`.
  
---
## Library
The executable embeds all the necessary dll's in the single file. It includes the math library also. So this tool supports various
operators like ```(+ x y z), (- x y), (* x y), (/ x y), (sin x), (cos x), (tan x), (asin x), (acos x), (atan x), (sinh x), (cosh x), 
(tanh x), (sqrt x), (log x), (exp x), (floor x), (ceiling x)```. Especially, x^3 is converted to `(expt x 3)`.  
  
The tool itself provides a documentation about conversion of equation formats. For example,   
           <img src="https://latex.codecogs.com/svg.latex?\inline&space;\small&space;\small&space;1.5\,&space;\mathrm{cos}(\omega&space;t-kx&plus;\frac{\pi}{2})" title="\small \small 1.5\, \mathrm{cos}(\omega t-kx+\frac{\pi}{2})" />   
is converted into `(* 1.5 (cos (+ (* w t) (-1 k x) (/ pi 2)) ) )`.
  
## Using
In Linux, open the terminal and navigate to /bin, use command `./calculus-tool` to open the executable.  
Under the calculus-toolbox/standalone-executables/ folder, you can find the standalone executable files that can be run on Linux and Windows.
  
---
## Instruction
Below describes the features of this tool.
  
### Solving equation
In the main menu, enter `1` to navigate to calculus menu, and then hit another `1` to arrive here.  
In this screen, type your function and be sure to include the variable `x` only. For example, to solve x^3 - e^x + 3 = 0, you need to
type `(+ (expt x 3) (- (exp x)) 3)`, then hit enter. Since the tool uses Newton's method to evaluate, it will then ask you for an initial
 guess, type any number you think will be close to a solution. For precision, you can input `0.001` or other small numbers; the tool
 uses this to find the derivative. The next step is to determine how many resursive calls it will evaluate the root, since the sequence <img src="https://latex.codecogs.com/svg.latex?\small&space;x_{n&plus;1}=x_0-f(x_0)/f'(x_0)" title="\small x_{n+1}=x_0-f(x_0)/f'(x_0)" />  converges fast, you don't need to input a number that's too large.  
The tool will print a solution after you hit enter, or reports an error if the input format is not correct.  
<a href="https://ibb.co/GPxKfdR"><img src="https://i.ibb.co/C01kpwQ/solve12.png" alt="solve12" border="1"></a>  
You can later change your initial guess to find other solutions.  
The programme will remember the input data from the last state it is run.  
### Derivative
In this screen, also make sure include the variable `x`; this programme doesn't support other variables as input. You can input your desired point and precison. Note this precision represent the term h in the formula <img src="https://latex.codecogs.com/svg.latex?\small&space;f'(x)=[f(x&plus;h)-f(x)]/h" title="\small f'(x)=[f(x+h)-f(x)]/h" />. The result after evaluation will be then printed.
If you also want the left derivative, you can go to the `additional` menu to do the exact same steps, which is useful for determining
whether the derivative exists.
### Integration
Like others, you have to include `x` and syntax. You will be asked to input the lower bound (from), the upper bound (to) and precision.
Note this precision "delta" represents the length of the step <img src="https://latex.codecogs.com/svg.latex?\small&space;\left&space;\|&space;P&space;\right&space;\|" title="\small \left \| P \right \|" /> for the partition. This tool creates
a uniform partition with that length (except the last sub-interval, please see [code](github.com/cleoold/Math-expressions-or-racket-/blob/folder1/math-num-integral.rkt) for info) and sum the average values of two ends of the subinterval according to the midpoint rule. This process can be described as  
<img src="https://latex.codecogs.com/svg.latex?\small&space;\int_{[a,b]}f=\sum&space;_{k=1}^{N=\left&space;\lfloor&space;(b-a)/\delta&space;\right&space;\rfloor}\frac{1}{2}[f(p_{k-1})&plus;f(p_k)]\left&space;\|&space;P&space;\right&space;\|&plus;\frac{1}{2}[f(p_N)&plus;f(p_{N&plus;1})][b-a-N\left&space;\|&space;P&space;\right&space;\|]" title="\small \int_{[a,b]}f=\sum _{k=1}^{N=\left \lfloor (b-a)/\delta \right \rfloor}\frac{1}{2}[f(p_{k-1})+f(p_k)]\left \| P \right \|+\frac{1}{2}[f(p_N)+f(p_{N+1})][b-a-N\left \| P \right \|]" />  
If you want to evaluate the left or right integral, you can go to the `additional` menu to do so. This is useful for determining if 
the integral exists; if the programme crashes, then it is not integrable over the interval.
### Recurrence sequence
