# Ridgeless Regression

Let $Y$ be a $n$-dimensional random vector and $X$ be a $n\times p$ random matrix. We are interested in the linear model
$$
Y = X\beta + U,
$$
where $U$ is a $n$-dimensional random vector with $\mathbb E[U]=0$.

The OLS estimator is 
$$
\widehat \beta = (X^\top X)^{-1}X^\top Y.
$$

The OLS estimator is the best linear unbiased estimator (BLUE) under the Gauss-Markov assumptions.


## The Consequence of $p/n \to c \in (0,1)$

In this regime we still have $p<n$, so $X^\top X$ is typically invertible and OLS is well-defined. However, OLS no longer has the ``classical'' behavior (where $p$ is fixed and $n\to\infty$). Intuitively, the model has $p\approx cn$ degrees of freedom, so it can fit not only the signal $X\beta$ but also a non-negligible fraction of the noise.

### Hat-matrix view: why OLS overfits

Let
$$
H = X(X^\top X)^{-1}X^\top \in \mathbb R^{n\times n}
$$
be the hat matrix. Then
$$
\widehat Y = HY,\qquad \widehat U = Y-\widehat Y = (I_n-H)Y.
$$
The matrix $H$ is an orthogonal projection onto the column space of $X$, and
$$
\mathrm{tr}(H)=\mathrm{rank}(H)=\mathrm{rank}(X)=p.
$$
So OLS effectively uses $p$ degrees of freedom to fit $Y$. When $p/n\to c$, the fraction of degrees of freedom used does not vanish.

In the correctly specified homoskedastic model with fixed $X$ and $\mathbb E[U\mid X]=0$, $\mathbb E[UU^\top\mid X]=\sigma^2 I_n$, we have
$$
\mathbb E\big[\|\widehat U\|_2^2\mid X\big] = \sigma^2\,\mathrm{tr}(I_n-H)=\sigma^2(n-p).
$$
Hence the in-sample mean squared residual satisfies
$$
\mathbb E\Big[\tfrac1n\|Y-X\widehat\beta\|_2^2\,\Big|\,X\Big]=\sigma^2\Big(1-\tfrac pn\Big)\to \sigma^2(1-c).
$$
This is strictly smaller than $\sigma^2$ when $c>0$: the training error is mechanically low because OLS projects out $p$ components of the noise. This is one precise sense in which OLS ``overfits'' as $p/n$ stays away from zero.

### Variance inflation: why estimation/prediction deteriorates

The estimation error is
$$
\widehat\beta-\beta = (X^\top X)^{-1}X^\top U.
$$
Conditional on $X$,
$$
\mathrm{Var}(\widehat\beta\mid X)=\sigma^2 (X^\top X)^{-1}.
$$
When $p/n\to c\in(0,1)$, the eigenvalues of $\tfrac1n X^\top X$ typically do not concentrate at a single constant; in particular, the smallest eigenvalues can be close to zero when $c$ is close to $1$. Inverting $X^\top X$ amplifies those directions, so $\widehat\beta$ becomes noisy and unstable.

This instability shows up in out-of-sample prediction. Let $x_{\mathrm{new}}$ be a new regressor vector (independent of the noise). The prediction error satisfies
$$
x_{\mathrm{new}}^\top(\widehat\beta-\beta)
$$
and its variance inherits the inflation from $(X^\top X)^{-1}$. In simple isotropic designs one obtains that test risk increases as $c$ increases and diverges as $c\uparrow 1$.

Summary: when $p/n\to c>0$, OLS can drive training error down by fitting part of the noise (since $\mathrm{tr}(H)=p\approx cn$), while the inverse $(X^\top X)^{-1}$ becomes ill-conditioned, inflating variance and harming out-of-sample performance.


## Failure of OLS when $p > n$

When the number of parameters $p$ exceeds the number of observations $n$, the OLS estimator fails because:

1. **Singular Matrix Problem**: The matrix $X^\top X$ is $p \times p$ but has rank at most $\min(n,p) = n < p$. Therefore, $X^\top X$ is singular and not invertible.

2. **Geometric Intuition**: With $n$ observations in $\mathbb{R}^p$, the data points lie in an at most $n$-dimensional subspace. When $p > n$, there are infinitely many hyperplanes that can perfectly fit the data (interpolation).

3. **Perfect Fit**: The system $Y = X\beta$ is underdetermined. There exist infinitely many solutions $\beta$ such that $X\beta = Y$, meaning we can achieve zero residual sum of squares.

This is why regularization methods like ridge regression are necessary in high-dimensional settings.

## Ridgeless regression as the minimum $\ell_2$-norm estimator when $p > n$

When $p>n$ and $\text{rank}(X)=n$ (full row rank), the system
$$
X\beta = Y
$$
is underdetermined: there are infinitely many $\beta$ that interpolate the data (achieve zero training residual).

The ridgeless (minimum-norm) estimator is defined as the interpolating solution with the smallest Euclidean norm:
$$
\widehat\beta_{\mathrm{mn}} \in \arg\min_{\beta\in\mathbb R^p}\|\beta\|_2^2 \quad \text{s.t.} \quad X\beta = Y.
$$

Using the Lagrangian
$$
\mathcal L(\beta,\lambda)=\tfrac12\|\beta\|_2^2 + \lambda^\top (Y-X\beta),
$$
the first-order condition in $\beta$ gives $\beta = X^\top\lambda$. Imposing the constraint yields
$$
X\beta = XX^\top\lambda = Y \quad \Rightarrow \quad \lambda = (XX^\top)^{-1}Y,
$$
so
$$
\widehat\beta_{\mathrm{mn}} = X^\top(XX^\top)^{-1}Y.
$$
This equals the Moore-Penrose pseudoinverse solution $\widehat\beta_{\mathrm{mn}} = X^+Y$ (in the full-row-rank case $X^+=X^\top(XX^\top)^{-1}$).

Null-space intuition: if $\beta_0$ satisfies $X\beta_0=Y$, then every interpolating solution is $\beta_0+v$ with $v\in\text{null}(X)$. The minimum-norm interpolator chooses the representative with no null-space component.

Connection to ridge: the ridge estimator $\widehat\beta_\lambda=(X^\top X+\lambda I_p)^{-1}X^\top Y$ converges (under suitable rank conditions) to $X^\top(XX^\top)^{-1}Y$ as $\lambda\downarrow 0$.
