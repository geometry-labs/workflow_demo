#include <Rcpp.h>

using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix rcpp_nested_loops(
    const NumericMatrix& x,
    const IntegerMatrix& y
) {
  const int n = x.nrow();
  NumericMatrix result(n, n);

  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      result(i, j) = std::sqrt(std::abs(
        x(y(i,j)-1, y(j,i)-1) * x(y(j,i)-1, y(i,j)-1)
      ));
    }
  }

  return result;
}
