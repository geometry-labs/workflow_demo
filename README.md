# README

## Changelog

We have implemented serial solutions in both **Rcpp** (see: [src/rcpp_nested_loops.cpp](src/rcpp_nested_loops.cpp)) and
**cpp11** (see: [src/cpp11_nested_loops.cpp](src/cpp11_nested_loops.cpp)).

We have also implemented a solution with **parallelized Rcpp** (see: [src/rcpp_nested_loops_parallel.cpp](src/rcpp_nested_loops_parallel.cpp)).

To add the parallelized implementation to the test suite, we added a function to [R/nestedLoops.R](R/nestedLoops.R)
called `nestedLoopsRcppParallelized`, along with a test
inside [tests/testthat/test-nestedLoops.R](tests/testthat/test-nestedLoops.R).

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

## Parallelization Demo Limitations / Future Work

The parallelized version ([src/rcpp_nested_loops_parallel.cpp](src/rcpp_nested_loops_parallel.cpp)) is included to
showcase the workflow. The toy function is quite lightweight, so the impact of parallelization is not particularly
dramatic.

For simplicity, the demo implementation uses as many threads as possible, while dividing the number of rows evenly. In
some cases (like 8 cores and 15 tasks) this approach results in idle threads; more sophisticated job schedulers can be
implemented to improve core utilization, if the effect is present and significant in applied OSPEAD calculations.

Once we have a more realistic function, we can experiment with different optimization strategies. Additionally,
productionalization of the actual OSPEAD computations will require further attention to thread locking, synchronization, and other
nuances of parallelizing specific applications.
