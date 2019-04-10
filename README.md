

With this tool, you can do math and engineering calculations, such as integrals, recurrence sequences and vectors, more easily.
All you need to do are to stick with some function syntax in Scheme (like using brackets `()`) to enter formulas, and put integers
to select things in my menu.  
  
The repository containing the source codes is located [page](https://github.com/cleoold/calculus-toolbox). The programme is written in Scheme, you can
open the file `runme.scm` in the main folder in `Drracket` to run it (as it includes `#lang scheme` prefix). If you are using a different 
interpreter or compiler, you might need the corresponding module and comment out that `#`.
  
---
## Library
The executable embeds all the necessary dll's in the single file. It includes the math library also. So this tool supports various
operators like ```(+ x y z), (- x y), (* x y), (/ x y), (sin x), (cos x), (tan x), (asin x), (acos x), (atan x), (sinh x), (cosh x), 
(tanh x), (sqrt x), (log x), (exp x), (floor x), (ceiling x)```. Especially, x^3 is converted to `(expt x 3)`.  
  
The tool itself provides a documentation about conversion of equation formats. For example, <img src="https://latex.codecogs.com/svg.latex?\inline&space;\small&space;\small&space;1.5\,&space;\mathrm{cos}(\omega&space;t-kx&plus;\frac{\pi}{2})" title="\small \small 1.5\, \mathrm{cos}(\omega t-kx+\frac{\pi}{2})" /> is converted into `(* 1.5 (cos (+ (* w t) (-1 k x) (/ pi 2)) ) )`.
  
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
 uses this to find the derivative. The next step is to determine how many resursive calls it will evaluate the root, since the sequence <img src="https://latex.codecogs.com/svg.latex?\small&space;x_{n&plus;1}=x_n-f(x_n)/f'(x_n)" title="\small x_{n+1}=x_n-f(x_n)/f'(x_n)" />  converges fast, you don't need to input a number that's too large.  
The tool will print a solution after you hit enter, or reports an error if the input format is not correct.  
    
⋅⋅⋅<a href="https://ibb.co/GPxKfdR"><img src="https://i.ibb.co/C01kpwQ/solve12.png" alt="solve12" border="1"></a>  
You can later change your initial guess to find other solutions.  
The programme will remember the input data from the last state in which it is run.  
### Derivative
In this screen, also make sure include the variable `x`; this programme doesn't support other variables as input. You can input your desired point and precison. Note this precision represents the term _h_ in the formula <img src="https://latex.codecogs.com/svg.latex?\small&space;f'(x)=[f(x&plus;h)-f(x)]/h" title="\small f'(x)=[f(x+h)-f(x)]/h" />. The result after evaluation will be then printed.
If you also want the left derivative, you can go to the `additional` menu to do the exact same steps, which is useful for determining
whether the derivative exists.  
After the update on April 2019, a second derivative feature is added.
### Integration
Like others, you have to include `x` and syntax. You will be asked to input the lower bound (from), the upper bound (to) and precision.
Note this precision _"delta"_ represents the length of the step <img src="https://latex.codecogs.com/svg.latex?\small&space;\left&space;\|&space;P&space;\right&space;\|" title="\small \left \| P \right \|" /> for the partition. This tool creates
a uniform partition with that length (if delta cannot divide the length of the interval, a shorter interval is created to terminate the programme, please see [code](https://github.com/cleoold/Math-expressions-or-racket-/blob/folder1/math-num-integral.rkt) for info) and sum the average values of two ends of the subinterval according to the midpoint rule. This process can be described as  
<img src="https://latex.codecogs.com/svg.latex?\small&space;\int_{[a,b]}f=\sum&space;_{k=1}^{N=\left&space;\lfloor&space;(b-a)/\delta&space;\right&space;\rfloor}\frac{1}{2}[f(p_{k-1})&plus;f(p_k)]\left&space;\|&space;P&space;\right&space;\|&plus;\frac{1}{2}[f(p_N)&plus;f(p_{N&plus;1})][b-a-N\left&space;\|&space;P&space;\right&space;\|]" title="\small \int_{[a,b]}f=\sum _{k=1}^{N=\left \lfloor (b-a)/\delta \right \rfloor}\frac{1}{2}[f(p_{k-1})+f(p_k)]\left \| P \right \|+\frac{1}{2}[f(p_N)+f(p_{N+1})][b-a-N\left \| P \right \|]" />  
In which the term on the right can be avoided upon decreasing value of precision, or by using rational bounds.
If you want to evaluate the left or right integral, you can go to the `additional` menu to do so. This is useful for determining if 
the integral exists; if the programme crashes, then it is not integrable over the interval.
### Recurrence sequence
If a sequence is determined recursively, then this tool provides great help for building a table and summing terms.  
Before using, please acknowdge that the index of a sequence starts from __0__. if a term is determined recursively by its previous
term, then it needs one base value. Such sequences look like <img src="https://latex.codecogs.com/svg.latex?\inline&space;\small&space;\left&space;\{&space;a:a_0=A,a_k=f(a_{k-1})&space;\right&space;\}" title="\small \left \{ a:a_0=A,a_k=f(a_{k-1}) \right \}" /> . In this case, enter `1`. If a term is determined by two of its previous values, then it needs two base values, and (possibly) looks like
<img src="https://latex.codecogs.com/svg.latex?\inline&space;\small&space;\left&space;\{&space;a:a_0=A,a_1=B,a_k=f(a_{k-2},a_{k-1})&space;\right&space;\}" title="\small \left \{ a:a_0=A,a_1=B,a_k=f(a_{k-2},a_{k-1}) \right \}" />. For this, enter `2`.  
Now you can enter your A, and B if necessary. In the next step, if you entered `1`, then include `x` in your expression. That `x` represents the last term based on generating the new term. If you entered `2`, then use `x` for <img src="https://latex.codecogs.com/svg.latex?\inline&space;\small&space;a_{k-2}" title="\small a_{k-2}" />, and `y` for <img src="https://latex.codecogs.com/svg.latex?\inline&space;\small&space;a_{k-1}" title="\small a_{k-1}" />.  
  
You can then input your order to evaluate things, below shows a sequence defined by <img src="https://latex.codecogs.com/svg.latex?\inline&space;\small&space;\left&space;\{a:&space;a_0=1,a_1=1,a_k=\sqrt{a_{k-2}}&plus;\sqrt{a_{k-1}}&space;\right&space;\}" title="\small \left \{a: a_0=1,a_1=1,a_k=\sqrt{a_{k-2}}+\sqrt{a_{k-1}} \right \}" />.  
⋅⋅⋅<a href="https://imgur.com/c5FBV5Y"><img src="https://imgur.com/c5FBV5Y" alt="4211245" border="1"></a>

### Gradient
This menu calculates partial derivative, gradient, and directional derivative for a function defined by multiple variables.
To start, enter your list of variables enclosed by brackets in the first screen, then input the function that has these variables.
For example, for <img src="https://latex.codecogs.com/svg.latex?\inline&space;\small&space;f(x,y,z)=\sqrt[3]{xyz}" title="\small f(x,y,z)=\sqrt[3]{xyz}" />, you need to enter `(x y z)` first, then `(expt (* x y z) 1/3)` second. The program will turn it into a 
lambda expression for that expression.  
Now for each of the three features, you need to input points (or vectors). For example, if you want to type in a point (2 5 2.2),
then simply type in `(2 5 2.2)` for that. Also, they need the precision input, this is the same as in the previous derivative section.
Below shows a calculation for directional derivative at (2 3 9.2), followed by the gradient.  
<a href="https://ibb.co/H4zPK2F"><img src="https://i.ibb.co/fFpNXS1/523t3.png" alt="523t3" border="0"></a>  
## Decimal conversion
This tool in under the `additional` menu. You can do the conversion from decimal to baseN (N >= 2), or from baseN to decimal
(1 <= N < 10). The algorithm can be found [here](https://github.com/cleoold/Math-expressions-or-racket-/blob/folder1/binary.rkt).  
⋅⋅⋅<a href="https://imgbb.com/"><img src="https://i.ibb.co/NKnXSqk/53243.png" alt="53243" border="0"></a>  
## Product of vector
You can find this option under the `vector` menu. You can input your vector u first, followed by v. The tool will compute their dot
product for you, and if the length is 3, then it also returns the vector u × v.  
⋅⋅⋅<a href="https://imgbb.com/"><img src="https://i.ibb.co/KhqGcTp/42523.png" alt="42523" border="0"></a><br />
## Projection
This feature produces three vectors at once upon you inputting two vectors. After you enter x first and then u, the followings are returned in order:
  1. Projection of vector x onto vector u. <img src="https://latex.codecogs.com/svg.latex?\inline&space;[\mathrm{prj_\mathbf{u}}]\mathbf{x}=\frac{\mathbf{u\cdot&space;x}}{\mathbf{u}^2}\mathbf{u}" title="[\mathrm{prj_\mathbf{u}}]\mathbf{x}=\frac{\mathbf{u\cdot x}}{\mathbf{u}^2}\mathbf{u}" />
  2. Perpendicular of vector x onto vector u. <img src="https://latex.codecogs.com/svg.latex?\inline&space;[\mathrm{perp_\mathbf{u}}]\mathbf{x}=\mathbf{x}-[\mathrm{prj_\mathbf{u}}]\mathbf{x}" title="[\mathrm{perp_\mathbf{u}}]\mathbf{x}=\mathbf{x}-[\mathrm{prj_\mathbf{u}}]\mathbf{x}" />
  3. reflection of vector x onto the hyperplane with normal u. <img src="https://latex.codecogs.com/svg.latex?\inline&space;[\mathrm{refl_\mathbf{u}}]\mathbf{x}=\mathbf{x}-[\mathrm{prj_\mathbf{u}}]2\mathbf{x}" title="[\mathrm{refl_\mathbf{u}}]\mathbf{x}=\mathbf{x}-[\mathrm{prj_\mathbf{u}}]2\mathbf{x}" />

### And more minor tools
The tool also provides vector rotation, vector molulo, sum/product of sequence and more.

---
## Progress
I give up on vector addition, hexadecimal conversion, building function table, etc as they are less challenging and can be found anywhere on-line or on your scientific calculator. In the future, I will plan to implement approximations of double integral, and some matrix operations such as multiplication and determinants.


