# Bootstrap

Bootstrap is a simulation-based method for approximating the sampling distribution of an estimator using the observed data. It is especially attractive for nonlinear models such as the maximum likelihood estimation (MLE), where point estimation is often straightforward but analytic variance formulas can be tedious to derive and implement.

## Inference about MLE

Let $Y_1,\ldots,Y_n$ be an i.i.d. sample from an unknown distribution $F$. Suppose we posit a parametric likelihood $f(x\mid \theta)$ and compute the MLE

$$
\hat\theta = \arg\max_{\theta\in\Theta} \ \ell_n(\theta),
$$

The optimizer gives a **point estimate** $\hat\theta$. To conduct inference (standard errors, confidence intervals, hypothesis tests), we need an estimate of the dispersion of $\hat\theta$ across repeated samples---i.e., we need an estimate of $\mathrm{Var}(\hat\theta)$ or its asymptotic analogue.

Under standard regularity conditions, $\hat\theta$ is asymptotically normal. If the model is correctly specified at $\theta_0$, then typically

$$
\sqrt{n}\,(\hat\theta-\theta_0)\ \Rightarrow\ N(0,\ I(\theta_0)^{-1}),
$$

where $I(\theta_0)$ is the Fisher information. If the model is misspecified, the MLE converges to a pseudo-true parameter $\theta^\star$, and the asymptotic variance takes the sandwich form

$$
\sqrt{n}\,(\hat\theta-\theta^\star)\ \Rightarrow\ N(0,\ V),
\qquad
V = H^{-1} J H^{-1}.
$$

Even when numerical differentiation or automatic differentiation is available, there is still human time involved: checking derivatives/Hessians, handling vector parameters carefully, and keeping the implementation stable across models. Bootstrap provides an alternative route that takes more computing time but saves human time.

## Nonparametric bootstrap

Let $T_n$ be an estimator viewed as a functional of the data distribution: $\hat\theta = T_n(F)$. The finite-sample distribution of $T_n(F)$ depends on the unknown $F$. Asymptotic methods uses $T_{\infty}(F) = \lim_{n \to \infty} T_n(F)$ to approximate the finite sample target $T_n(F)$. If the statistic $T_{\infty}(F)$ is pivotal, it does not depend on $F$ any more. For example, the $t$-statistic under many different distributions ends up as normal as $n\to \infty$, where the original distribution $F$ drops out. Even if $T_{\infty}(F)$ still depends on some unknown parameter in $F$, these unknown parameters can often be replaced by plugging in a consistent estimator. This is the idea behind asymptotic inference.

Bootstrap takes an alternative route. It replaces $F$ by the empirical distribution function (EDF)
$$
\hat F_n(\cdot) := \frac{1}{n}\sum_{i=1}^n \mathbf{1}\{Y_i \le \cdot\},
$$

and approximates the sampling distribution of $\hat\theta$ under $F$ by the **bootstrap distribution** of

$$
\hat\theta^\star := T_n(\hat F_n),
$$

obtained by repeatedly resampling from $\hat F_n$ (i.e., sampling the observed data with replacement) and recomputing the estimator.


1. Compute the MLE $\hat\theta$ from the original sample.
2. For $b=1,\ldots,B$:
   1. Draw a bootstrap sample $Y_1^{\star(b)},\ldots,Y_n^{\star(b)}$ by sampling **with replacement** from $\{Y_i\}_{i=1}^n$.
   2. Recompute the MLE on the bootstrap sample:
      $$
      \hat\theta^{\star(b)} = \arg\max_{\theta\in\Theta} \ \ell_n^{\star(b)}(\theta).
      $$
3. Estimate variance (and standard errors) by the sample covariance of $\{\hat\theta^{\star(b)}\}_{b=1}^B$:
   $$
   \widehat{\mathrm{Var}}_{\text{boot}}(\hat\theta)
   := \frac{1}{B-1}\sum_{b=1}^B\left(\hat\theta^{\star(b)}-\bar\theta^\star\right)\left(\hat\theta^{\star(b)}-\bar\theta^\star\right)',
   \quad
   \bar\theta^\star := \frac{1}{B}\sum_{b=1}^B \hat\theta^{\star(b)}.
   $$

If the object of interest is a scalar $\psi=g(\theta)$ (e.g., a marginal effect, an elasticity, a counterfactual prediction), compute $\psi^{\star(b)}=g(\hat\theta^{\star(b)})$ each time and use the bootstrap distribution of $\{\psi^{\star(b)}\}$ to form standard errors and confidence intervals.

## Parametric bootstrap

If you are willing to take the likelihood model seriously as a data-generating mechanism, parametric bootstrap replaces "resampling the data" by "resampling from the fitted model":

1. Fit the model and obtain $\hat\theta$.
2. For $b=1,\ldots,B$:
   1. Simulate $Y_1^{\star(b)},\ldots,Y_n^{\star(b)} \stackrel{i.i.d.}{\sim} f(\cdot\mid \hat\theta)$.
   2. Re-estimate to obtain $\hat\theta^{\star(b)}$.
3. Use the dispersion of $\{\hat\theta^{\star(b)}\}$ for standard errors and inference.

Parametric bootstrap can be very accurate when the model is correctly specified, while nonparametric bootstrap is more agnostic because it uses the EDF $\hat F_n$.

## Practical notes

- **Bootstrap is a loop.** Conceptually it is simple; computational cost is the price you pay. You solve the estimation problem $B$ additional times.
- **Choice of $B$.** Larger $B$ reduces Monte Carlo noise in your standard errors/quantiles. In practice, you often start with $B=100$ or $200$ for debugging, then increase (e.g., $B=1000$ or more) for final results.
- **Dependence.** For time series or clustered data, naive i.i.d. resampling breaks dependence. Use block bootstrap or cluster bootstrap to preserve the relevant dependence structure.

## Bootstrap hypothesis testing

Bootstrap can approximate the full sampling distribution of a statistic, which can be used to compute critical values and $p$-values. The key conceptual point is that hypothesis testing requires a null distribution.

Suppose we want to test $H_0:\ \theta=\theta_0$ using a statistic $T_n=T_n(Y_1,\ldots,Y_n)$. A naive nonparametric bootstrap mimics repeated sampling from the unknown $F$, so it approximates the distribution of $T_n$ under the true data-generating process. That is not automatically the same as the distribution of $T_n$ under $H_0$.

### Recenter the statistic

Instead of generating bootstrap samples under $H_0$, one may resample from $\hat F_n$ but use a **recentered** statistic whose bootstrap distribution is centered at the sample estimate. This is often used with $t$-statistics.

For a scalar parameter, consider
$$
t = \frac{\hat\theta-\theta_0}{\widehat{\mathrm{se}}(\hat\theta)}.
$$
After drawing a bootstrap sample and recomputing the estimator, form the bootstrap analogue
$$
t^{\star(b)} = \frac{\hat\theta^{\star(b)}-\hat\theta}{\widehat{\mathrm{se}}^{\star(b)}}.
$$
The centering is crucial: the numerator uses $\hat\theta^{\star(b)}-\hat\theta$ (centered at the sample estimate), not $\hat\theta^{\star(b)}-\theta_0$. This makes the bootstrap distribution of $t^{\star(b)}$ approximate the sampling distribution of $(\hat\theta-\theta)/\widehat{\mathrm{se}}(\hat\theta)$, which is the object needed to calibrate the null distribution of $t$.

For a two-sided test, the bootstrap $p$-value is
$$
\hat p = \frac{1}{B}\sum_{b=1}^B \mathbf{1}\left\{ |t^{\star(b)}| \ge |t| \right\}.
$$
Equivalently, let $c_{1-\alpha}^\star$ be the $(1-\alpha)$ empirical quantile of $\{|t^{\star(b)}|\}$ and reject $H_0$ when $|t|>c_{1-\alpha}^\star$.


## Bootstrap confidence intervals
Let $\psi$ be a scalar object of interest. It could be a component of $\theta$ or a transformation $\psi=g(\theta)$ (e.g., a marginal effect). Compute the original estimate $\hat\psi=g(\hat\theta)$. Then generate bootstrap replicates $\hat\psi^{\star(1)},\ldots,\hat\psi^{\star(B)}$ by resampling and re-estimating.

Bootstrap confidence intervals use the empirical distribution of $\{\hat\psi^{\star(b)}\}$ (and sometimes of a studentized statistic) to approximate the sampling uncertainty of $\hat\psi$.

The "basic" bootstrap interval recenters the bootstrap distribution around the original estimate:

$$
\mathrm{CI}_{\text{basic}}(1-\alpha)
= \left[2\hat\psi-\hat q_{1-\alpha/2}^\star,\ 2\hat\psi-\hat q_{\alpha/2}^\star\right].
$$

It can be viewed as inverting the bootstrap distribution of the centered quantity $\hat\psi^\star-\hat\psi$.

### Connection to hypothesis testing

A confidence interval can be obtained by inverting a family of tests. In bootstrap, this perspective is useful for remembering what should be centered where:

- For hypothesis tests you need a null distribution (so you either impose the null in the bootstrap DGP, or recenter a statistic appropriately).
- For confidence intervals you are calibrating the sampling uncertainty of $\hat\psi$, so recenters typically involve $\hat\psi$.
