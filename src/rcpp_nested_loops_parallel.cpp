#include <Rcpp.h>
#include <thread>
//#include <chrono>  // uncomment if enabling sleep for testing

using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix rcpp_parallel_nested_loops(
    const NumericMatrix& x,
    const IntegerMatrix& y
) {
  int n = x.nrow();
  NumericMatrix result(n, n);

  // Create a worker function that computes a subset of the matrix
  auto worker = [&](int start, int end) {
    for(int i = start; i < end; i++) {
      for(int j = 0; j < n; j++) {
        result(i, j) = std::sqrt(std::abs(
          x(y(i,j)-1, y(j,i)-1) * x(y(j,i)-1, y(i,j)-1)
        ));
        // std::this_thread::sleep_for(std::chrono::seconds(5));  // uncomment if enabling sleep for testing
      }
    }
  };

  // Determine the number of threads to use
  int num_threads = std::thread::hardware_concurrency();
  if(num_threads == 0) num_threads = 1;

  // If number of cores doesn't divide N, use the highest number of available threads that does
  if (n % num_threads != 0) {
    for (int i = num_threads; i >= 1; i--) {
      if (n % i == 0) {
        num_threads = i;
        break;
      }
    }
  }

  // Split the work into equal-sized chunks
  int chunk_size = n / num_threads;
  std::vector<std::thread> threads;

  for(int i = 0; i < num_threads; i++) {
    int start = i * chunk_size;
    int end = (i == num_threads - 1) ? n : (i + 1) * chunk_size;
    threads.push_back(std::thread(worker, start, end));
  }

  // Wait for all threads to finish
  for(auto& thread : threads) thread.join();

  return result;
}
