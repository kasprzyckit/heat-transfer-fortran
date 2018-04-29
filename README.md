# 1D heat transfer problem
Simple numerical solution to a heat transfer problem using FDM and visualisation of mean absolute error of the results for all of three levels of floating point precision in Fortran.

## The problem:
![equation](http://latex.codecogs.com/gif.latex?-k%5Cfrac%7Bd%5E%7B2%7Du%7D%7Bdx%5E%7B2%7D%7D%3D0)<br />
![equation](http://latex.codecogs.com/gif.latex?u%280%29%3D0)<br />
![equation](http://latex.codecogs.com/gif.latex?u%281%29%3D1)<br />

## Compilation & running the program
```
cmake CMakeLists.txt
./run.sh
```
This should work with both [gfortran](https://gcc.gnu.org/wiki/GFortran) or [ifort](https://software.intel.com/en-us/fortran-compilers) set as the defualt CMake Fortran compiler (preferably the former). In order to change the upper size boundary of the FDM grid, up to which errors are to be measured, change the "N" variable in the "run.sh" script. To run only selected level of precision comment out the appropriate lines.<br />
The visualisation program depends on **numpy** and **matplotlib** Python packages. <br />
<br />
Alternatively, after Makefile is generated, run the program directly, passing the FDM grid size boundary as the only argument.
```
./HeatTransfer_4 500
./HeatTransfer_8 100
./HeatTransfer_16 ...
```

## Project structure:
* **src/gauss.F90** - gaussian elimination function
* **src/fdm.F90** - filling the linear equation matrix and calculating the error

## Results
For N ∈ {10, 1000}, with 4 byte fp precision.<br />
![4byte](https://github.com/kasprzyckit/heat-transfer-fortran/blob/master/results/4b_1000.png)

For N ∈ {10, 1000}, with 8 byte fp precision.<br />
![8byte](https://github.com/kasprzyckit/heat-transfer-fortran/blob/master/results/8b_1000.png)

For N ∈ {10, 1000}, with 16 byte fp precision.<br />
![16byte](https://github.com/kasprzyckit/heat-transfer-fortran/blob/master/results/16b_1000.png)
