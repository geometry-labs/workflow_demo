#include <cpp11.hpp>
#include "cpp11/matrix.hpp"

using namespace cpp11;

[[cpp11::register]]
doubles_matrix<> cpp11_nested_loops(
    const doubles_matrix<>& x,
    const integers_matrix<>& y
) {
  const int n = x.nrow();
  writable::doubles_matrix<> result(n, n);

  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      result(i, j) = std::sqrt(std::abs(
        x(y(i,j)-1, y(j,i)-1) * x(y(j,i)-1, y(i,j)-1)
      ));
    }
  }

  return result;
}
