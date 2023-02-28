## code to prepare `nestedLoopsValidation` dataset goes here

# Use withr to avoid affecting global random seed
withr::with_seed(314, {
  mat.size <- 1000
  nestedLoopsValidationX <- matrix(runif(mat.size^2) - 0.5, nrow = mat.size)
  nestedLoopsValidationY <- matrix(sample(1:mat.size, mat.size^2, replace = TRUE), nrow = mat.size)

  nestedLoopsValidationResult <- nestedLoops(nestedLoopsValidationX, nestedLoopsValidationY)

  usethis::use_data(nestedLoopsValidationX, overwrite = TRUE)
  usethis::use_data(nestedLoopsValidationY, overwrite = TRUE)
  usethis::use_data(nestedLoopsValidationResult, overwrite = TRUE)

} )
