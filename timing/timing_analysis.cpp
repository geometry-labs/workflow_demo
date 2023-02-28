/* Helper code for analyzing timing results from parallelization experiments */

#include <iostream>

// Experiment configuration
int N = 12;
int threads = 12;
int sleep_time = 5000000; // microseconds

// Observed experiment results
int baseline_runtime = 390; // microseconds
int T_parallelized_observed = 60003130; // microseconds
int T_serial_observed = 720016293; // microseconds

int main() {

    // Check that threads divides N
    if (N % threads != 0) {
        std::cout << "Error: please configure timing experiments with N divisible by num_threads" << std::endl;
        return 1;
    }

    // Analysis
    double T_parallelized_expected = baseline_runtime + static_cast<double>(N * N * sleep_time) / threads;
    double T_serial_expected = baseline_runtime + N * N * sleep_time;
    double T_p_div = 100 * (T_parallelized_observed / T_parallelized_expected - 1);
    double T_s_div = 100 * (T_serial_observed / T_serial_expected - 1);

    std::cout << "Parallelized expected: " << int(T_parallelized_expected) << " microseconds" << std::endl;
    std::cout << "Parallelized observed: " << int(T_parallelized_observed) << " microseconds" << std::endl;
    std::cout << "Serial expected: " << int(T_serial_expected) << " microseconds" << std::endl;
    std::cout << "Serial observed: " << int(T_serial_observed) << " microseconds" << std::endl;
    std::cout << "Parallelized div: " << T_p_div << "%" << std::endl;
    std::cout << "Serial div: " << T_s_div << "%" << std::endl;

    return 0;
}

/*
    ------
    OUTPUT
    ------

    Parallelized expected: 60000390 microseconds
    Parallelized observed: 60003130 microseconds
    Serial expected: 720000390 microseconds
    Serial observed: 720016293 microseconds
    Parallelized div: 0.00456664%
    Serial div: 0.00220875%
 */
