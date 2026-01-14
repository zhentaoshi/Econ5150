# Statistics

We observe data $\{y_i\}_{i=1}^n$.

Under mean squared error (MSE), the sample mean is the best constant predictor:
$$
\bar y \in \arg\min_{c\in\mathbb{R}} \frac{1}{n}\sum_{i=1}^n (y_i-c)^2.
$$

This makes $\bar y$ the most important summary statistic because it is the optimal one-number description of the data when errors are measured in squared loss: it captures the overall location (first moment) of the sample, and it is the natural reference point for measuring dispersion and dependence via centered quantities such as $y_i-\bar y$ (variance, covariance, correlations) and for many large-sample results (e.g. the CLT for $\bar y$).

## Sample variance

The sample variance summarizes the dispersion of the data around its mean:
$$
s^2 \equiv \frac{1}{n}\sum_{i=1}^n (y_i-\bar y)^2.
$$

It is tightly connected to the MSE objective above via the identity (for any constant $c$)
$$
\frac{1}{n}\sum_{i=1}^n (y_i-c)^2 = \frac{1}{n}\sum_{i=1}^n (y_i-\bar y)^2 + (\bar y-c)^2 = s^2 + (\bar y-c)^2.
$$
This decomposition shows:

1. **Why $\bar y$ minimizes MSE**: the second term $(\bar y-c)^2$ is minimized at $c=\bar y$.

2. **Why variance is the ``irreducible'' part of MSE for constant prediction**: after choosing the best constant $c=\bar y$, the remaining average squared error is exactly $s^2$.

Sometimes one uses the unbiased sample variance
$$
\widetilde s^2 \equiv \frac{1}{n-1}\sum_{i=1}^n (y_i-\bar y)^2,
$$
which satisfies $\mathbb E[\widetilde s^2]=\mathrm{Var}(Y)$ under i.i.d. sampling.

## Histogram

A histogram is a nonparametric statistic that summarizes the empirical distribution, not just a few moments. Fix bin edges $a_0<a_1<\cdots<a_K$ and define the relative frequency in bin $k$ by
$$
\hat p_k \equiv \frac{1}{n}\sum_{i=1}^n \mathbf{1}\{a_{k-1}\le y_i < a_k\},\qquad k=1,\ldots,K.
$$
Plotting $\hat p_k$ (or $\hat p_k/(a_k-a_{k-1})$ to approximate a density) across bins estimates the shape of the underlying distribution without imposing a parametric form; the bin width controls the bias--variance tradeoff (wide bins smooth, narrow bins are noisy).

