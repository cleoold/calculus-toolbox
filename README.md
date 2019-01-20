# Calculus toolbox provides some easy computations related to math

With this tool, you can do math and engineering calculations, such as integrals, recurrence sequences and vectors, more easily.
All you need to do are to stick with some function syntax in Scheme (like using brackets `()`) to enter formulas, and put integers
to select things in my menu.  
  
The repository containing the source codes is located [page](github.com/cleoold/calculus-toolbox). The programme is written in Scheme, you can
open the file `runme.scm` in the main folder in `Drracket` to run it (as it includes `#lang scheme` prefix). If you are using a different 
interpreter or compiler, you might need the corresponding module.
  
---
### Library
The executable embeds all the necessary dll's in the single file. It includes the math library also. So this tool supports various
operators like ```(+ x y z), (- x y), (* x y), (/ x y), (sin x), (cos x), (tan x), (asin x), (acos x), (atan x), (sinh x), (cosh x), 
(tanh x), (sqrt x), (log x), (exp x), (floor x), (ceiling x)```. Especially, x^3 is converted to `(expt x 3)`.  
  
The tool itself provides a documentation about conversion of equation formats. For example,   
           <img src="https://latex.codecogs.com/svg.latex?\small&space;1.5\,&space;\mathrm{cos}(\omega&space;t-kx&plus;\frac{\pi}{2})" title="\small 1.5\, \mathrm{cos}(\omega t-kx+\frac{\pi}{2})" />   
is converted into `(* 1.5 (cos (+ (* w t) (-1 k x) (/ pi 2)) ) )`.
  
### Download
Under the calculus-toolbox/standalone-executables/ folder, you can find the standalone executable files that can be run on Windows 
and Linux.
