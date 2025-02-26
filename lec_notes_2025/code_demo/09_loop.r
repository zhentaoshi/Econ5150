# %%
# library(MASS)

mu <- 2

CI <- function(x) {
    # x is a vector of random variables
    n <- length(x)
    mu <- mean(x)
    sig <- sd(x)
    upper <- mu + 1.96 / sqrt(n) * sig
    lower <- mu - 1.96 / sqrt(n) * sig
    return(list(lower = lower, upper = upper))
}

capture <- function(i) {
    x <- rpois(sample_size, mu)
    bounds <- CI(x)
    return((bounds$lower <= mu) & (mu <= bounds$upper))
}

Rep <- 100000 # or whatever value you choose
sample_size <- 10 # or whatever value you choose
mu <- 10 # or whatever value you choose

out <- vector("logical", Rep) # initialize out as logical vector
pts0 <- Sys.time() # check time

for (i in 1:Rep) {
    out[i] <- capture(i)
}

pts1 <- Sys.time() - pts0 # check time elapsed
print(paste("loop without pre-definition takes", pts1, "seconds"))

out <- rep(FALSE, Rep) # initialize out as logical vector
pts0 <- Sys.time() # check time

for (i in 1:Rep) {
    if (i == 1) {
        out <- capture(i)
    } else {
        out <- c(out, capture(i))
    }
}

pts1 <- Sys.time() - pts0 # check time elapsed
print(paste("loop without pre-definition takes", pts1, "seconds"))
# %%
