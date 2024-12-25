fizzCount <- 0
buzzCount <- 0
fizzBuzzCount <- 0
sumAll <- 0
for(i in 1:1000) {
    if(i%%15 == 0) {
        fizzBuzzCount <- fizzBuzzCount + 1
    } else if(i%%3 == 0) {
        fizzCount <- fizzCount + 1
    } else if(i%%5 == 0) {
        buzzCount <- buzzCount + 1
    } else {
        sumAll <- sumAll + i
    }
}

v <- c(fizzCount, buzzCount, fizzBuzzCount, sumAll)
print(v)