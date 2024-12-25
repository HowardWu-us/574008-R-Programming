fib <- function(x) {
  if (x %in% 1:2) {
    return(1)
  } else {
    return(fib(x - 1) + fib(x - 2))
  }
}
print(fib(22))