input <- c(267, 134, 66, 266332)
ans <- c()

for (i in input) {
    tmp <- 0
    while(i != 1) {
        if(i%%2 == 0) {
            i <- i %/% 2
        } else {
            i <- 3*i+1
        }
        tmp <- tmp + 1
    }
    ans <- append(ans, tmp)
}

print(ans)