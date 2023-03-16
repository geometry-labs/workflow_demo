# README: R / C++ workflow demo

This repository is a demo showing how to take [pure R code](R/) to and convert it to [hybrid R/C++ code](src/).

The demo code was developed by [Cheyenne Atapour](https://github.com/cheyenneatapour) (lead)
and [Mitchell Krawiec-Thayer](https://github.com/mitchellpkt) at [Geometry Labs](https://geometrylabs.io), based on R
toy prototypes and tests provided by [Rucknium](https://github.com/Rucknium).

This codebase is released under the permissive [MIT license](LICENSE), and we welcome anybody to use and modify this
code in whole or part.

## Description

Both the serialized cpp11 and Rcpp implementations simply use a nested `for` loop that essentially mirrors the reference
R implementation. Since the input arrays are not updated during the execution of the functions, we pass them in as
constant references. This saves computation time and scales better, as the input arrays do not need to be copied on the
stack during the function call.

Within the parallel Rcpp implementation, we define a worker function that will be responsible for computing part of the
output matrix. We then divide the total work of the outer `for` loop into individual workers, corresponding to the
number of threads the executing machine has available. Then we run all these threads at the same time and wait for their
execution to complete, then we return the final output matrix.

## Testing

Our code can be checked, compiled and tested, respectively, the usual way within RStudio via:

+ Build --> Check Package
+ Build --> Install Package
+ Build --> Test Package

## Changelog

We have implemented serial solutions in both **Rcpp** (see: [src/rcpp_nested_loops.cpp](src/rcpp_nested_loops.cpp)) and
**cpp11** (see: [src/cpp11_nested_loops.cpp](src/cpp11_nested_loops.cpp)).

We have also implemented a solution with **parallelized Rcpp** (
see: [src/rcpp_nested_loops_parallel.cpp](src/rcpp_nested_loops_parallel.cpp)).

To add the parallelized implementation to the test suite, we added a function to [R/nestedLoops.R](R/nestedLoops.R)
called `nestedLoopsRcppParallelized`, along with a test
inside [tests/testthat/test-nestedLoops.R](tests/testthat/test-nestedLoops.R).

## Parallelization Demo: Limitations / Future Work

The parallelized version ([src/rcpp_nested_loops_parallel.cpp](src/rcpp_nested_loops_parallel.cpp)) is included to
showcase the workflow. The toy function is quite lightweight, so the impact of parallelization is not particularly
dramatic.

For simplicity, the demo implementation uses as many threads as possible, while dividing the number of rows evenly. In
some cases (like 8 threads and 15 tasks, or any prime number of tasks) this approach results in some idle resources.
More sophisticated job schedulers (or appropriately sized batching) can be implemented to improve resource utilization,
if the effect is present and significant in applied OSPEAD calculations.

One should experiment with different optimization strategies when implementing the actual target code. While this
version is nominally parallelized around the toy function, productionalization of real tasks
will require further attention to scheduling, thread locking, synchronization, and other nuances of parallelizing
specific applications.
