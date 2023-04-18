n <- 10000

x <- rnorm(n)
s <- cumsum(x) / sqrt(n)

step.xy <- stepfun(x = (1:n)/n, y = c(0,s) )

plot(step.xy, do.points = FALSE, xlim = c(0,1))
abline(h = 0)
