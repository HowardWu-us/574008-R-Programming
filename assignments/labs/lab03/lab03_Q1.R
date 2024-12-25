multiply_all <- function(input) {
  ans <- c(1)
  for (i in input) {
    ans <- c((ans * i) %% 65537)
  }
  return(ans)
}
print(multiply_all(c(20, 22, 10, 13)))
print(multiply_all(c(2022, 1013)))
print(multiply_all(c(1:30)))
