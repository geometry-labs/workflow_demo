# Helper code for analyzing timing results from parallelization experiments

# Experiment configuration
N <- 12
threads <- 12
sleep_time <- 5000000 # microseconds

# Observed experiment results
baseline_runtime <- 390 # microseconds
T_parallelized_observed <- 60003130 # microseconds
T_serial_observed <- 720016293 # microseconds

# Analysis
T_parallelized_expected <- baseline_runtime + (N * N * sleep_time) / threads
T_serial_expected <- baseline_runtime + N * N * sleep_time
T_p_div <- 100 * (T_parallelized_observed / T_parallelized_expected - 1)
T_s_div <- 100 * (T_serial_observed / T_serial_expected - 1)

cat(sprintf("Parallelized expected: %d microseconds\n", as.integer(T_parallelized_expected)))
cat(sprintf("Parallelized observed: %d microseconds\n", as.integer(T_parallelized_observed)))
cat(sprintf("Serial expected: %d microseconds\n", as.integer(T_serial_expected)))
cat(sprintf("Serial observed: %d microseconds\n", as.integer(T_serial_observed)))
cat(sprintf("Parallelized div: %f %%\n", T_p_div))
cat(sprintf("Serial div: %f %%\n", T_s_div))

#     ------
#     OUTPUT
#     ------
#
#     Parallelized expected: 60000390 microseconds
#     Parallelized observed: 60003130 microseconds
#     Serial expected: 720000390 microseconds
#     Serial observed: 720016293 microseconds
#     Parallelized div: 0.004567 %
#     Serial div: 0.002209 %