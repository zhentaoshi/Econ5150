# OLS Finite Sample Properties

Ordinary least squares (OLS) is the simplest method of supervised learning: it estimates coefficients using the training data by minimizing the sum of squared residuals, and then uses the fitted model to generate predictions (and assess out-of-sample performance) on test data.

OLS is the fundamental for nonlinear methods. 


## Mean and Variance

We represent the regression model as $Y=X\beta+e$ and
$$\begin{aligned}
E[e|X] & =0_{n}\\
\mathrm{var}\left[e|X\right] & =E\left[ee'|X\right]=\sigma^{2}I_{n}.\end{aligned}$$
where the first condition is the *mean independence* assumption, and the
second condition is the *homoskedasticity* assumption. These assumptions
are about the first and second *moments* of $e_{i}$ conditional on
$x_{i}$. Unlike the normality assumption, they do not restrict the
distribution of $e_{i}$.


-   Unbiasedness: $$\begin{aligned}
    E\left[\widehat{\beta}|X\right] & =E\left[\left(X'X\right)^{-1}XY|X\right]=E\left[\left(X'X\right)^{-1}X\left(X'\beta+e\right)|X\right]\\
     & =\beta+\left(X'X\right)^{-1}XE\left[e|X\right]=\beta.\end{aligned}$$
    By the law of iterated expectations, the unconditional expectation
    $E\left[\widehat{\beta}\right]=E\left[E\left[\widehat{\beta}|X\right]\right]=\beta.$
    Unbiasedness does not rely on homoskedasticity. The essential condition for unbiasedness is $E[e | X] = 0$. Notice that $e$ is an $n \times 1$ vector, and $X$ is an $n \times p$ matrix, which contains the entire dataset. In the time series context, it contain the entire history.

**Remark**. Strict exogeneity. Sequential exogeneity. Kendall's bias in AR(1). Stambaugh bias in predictive regressions.


-   Variance:
    $$\begin{aligned}\mathrm{var}\left[\widehat{\beta}|X\right] & =E\left[\left(\widehat{\beta}-E\widehat{\beta}\right)\left(\widehat{\beta}-E\widehat{\beta}\right)'|X\right]\\
     & =E\left[\left(\widehat{\beta}-\beta\right)\left(\widehat{\beta}-\beta\right)'|X\right]\\
     & =E\left[\left(X'X\right)^{-1}X'ee'X\left(X'X\right)^{-1}|X\right]\\
     & =\left(X'X\right)^{-1}X'E\left[ee'|X\right]X\left(X'X\right)^{-1}
    \end{aligned}$$ where the second equality holds as

-   Under the assumption of homoskedasticity, it can be simplified as
    $$\begin{aligned}\mathrm{var}\left[\widehat{\beta}|X\right] & =\left(X'X\right)^{-1}X'\left(\sigma^{2}I_{n}\right)X\left(X'X\right)^{-1}\\
     & =\sigma^{2}\left(X'X\right)^{-1}X'I_{n}X\left(X'X\right)^{-1}\\
     & =\sigma^{2}\left(X'X\right)^{-1}.
    \end{aligned}$$


**Remark**: Gauss-Markov theorem. BLUE and Generalized Least Squares.

**Example**. 
If $e_{i}=x_{i}u_{i}$, where $x_{i}$ is a scalar
random variable, $u_{i}$ is statistically independent of $x_{i}$,
$E\left[u_{i}\right]=0$ and $E\left[u_{i}^{2}\right]=\sigma_{u}^{2}$.
Then
$E\left[e_{i}|x_{i}\right]=E\left[x_{i}u_{i}|x_{i}\right]=x_{i}E\left[u_{i}|x_{i}\right]=0$
but
$E\left[e_{i}^{2}|x_{i}\right]=E\left[x_{i}^{2}u_{i}^{2}|x_{i}\right]=x_{i}^{2}E\left[u_{i}^{2}|x_{i}\right]=\sigma_{u}^{2}x_{i}^{2}$
is a function of $x_{i}$. We say $e_{i}^{2}$ is a heteroskedastic error.

It is important to notice that independently and identically distributed
sample (iid) $\left(y_{i},x_{i}\right)$ does not imply homoskedasticity.
Homoskedasticity or heteroskedasticity is about the relationship between
$\left(x_{i},e_{i}=y_{i}-\beta x\right)$ within an observation, whereas
iid is about the relationship between $\left(y_{i},x_{i}\right)$ and
$\left(y_{j},x_{j}\right)$ for $i\neq j$ across observations.

Given the conditional variance, it is easy to see that the unconditional variance is 

$$\begin{aligned}
\mathrm{var}\left[\widehat{\beta}\right] & =\sigma^{2} E \left[\left(X'X\right)^{-1} \right].
    \end{aligned}$$
The expectation of $(X'X)^{-1}$ depends on the underlying distribution. In a special case, we can write it in explicit form. Consider all entries of $x_i \sim N(0, \Sigma_X)$ and $x_1, \ldots, x_n$ are iid. If so, $X'X$ follows a Wishart distrubution, and 
$$
 E \left[\left(X'X\right)^{-1} \right] = \frac{\Sigma_X^{-1}}{n-p-1} .
$$

## In-sample Overfitting

In the population, $\mathrm{var}(x_i'\beta)$ is the signal, and $\sigma^2 = \mathrm{var}(e_i)$ is the noise. 

In sample, the (average) SSR

$$
SSR/n = \hat e' \hat e/n = e' (I_n-P_X)e
$$
and thus 
$$E [SSR/n] = \frac{\sigma^2}{n} \mathrm{trace}( I - P_X) = \sigma^2 (1- \frac{p}{n}).$$

## OOS prediction

Given the above assumption about $x_i$, 
$$
\mathrm{var}(x_{new}'\hat \beta) = E [ \beta' x_{new}\hat x_{new}'\hat \beta ] = \mathrm{trace}(\Sigma_X) \cdot \sigma^2 E \left[\left(X'X\right)^{-1} \right]  = \sigma^2 \frac{p}{n-p-1}
$$

Given that in any prediction problems, there is always the unpredictable noise $\sigma^2$, the total prediction variance is 
$$
\mathrm{var}(x_{new}'\hat \beta) + \sigma^2 = \sigma^2 \frac{p}{n-p-1} + \sigma^2 = \sigma^2 \left(1 + \frac{p}{n-p-1}\right) = \sigma^2 \frac{n-1}{n-p-1}.
$$
If $p$ is proportional to $n$, it will inflate the prediction variance. If we ignore $1$, when $p:n = 4:5$, the prediction variance is about $5$ times the noise variance. Ideally, we only want 1 time of the noise variance.

<!-- we have $\mathrm{var}(x_i'  \beta) = \beta' \Sigma_X \beta$.  -->