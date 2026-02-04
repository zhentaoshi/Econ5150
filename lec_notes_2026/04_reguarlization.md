# Shrinkage Methods

We observe training data $\{(y_i, x_i)\}_{i=1}^n$ where $x_i$ is a $p$-dimensional regressor. Stack the $n$ observations into the vector $Y$ and the regressors into the matrix $X$. The linear model is
$$
Y = X\beta + e.
$$

**Ridge regression** stabilizes the fit by shrinking coefficients toward zero via an $\ell_2$ penalty:
$$
\widehat{\beta}_{ridge}(\lambda) = \arg\min_{\beta \in \mathbb{R}^p}
\Big\{ \frac{1}{n} \|Y - X\beta\|_2^2 + \lambda \|\beta\|_2^2 \Big\},
\qquad \lambda \ge 0.
$$
The tuning parameter $\lambda$ controls the amount of shrinkage: $\lambda=0$ recovers OLS (when it exists), and larger $\lambda$ shrinks coefficients more strongly.



The penalized problem is equivalent (for an appropriate mapping between $\lambda$ and $t$) to the constrained least squares problem
$$
\min_{\beta} \ \frac{1}{n}\|Y - X\beta\|_2^2 \quad \text{s.t.} \quad \|\beta\|_2^2 \le t,
$$
which makes the geometry clear: ridge restricts $\beta$ to lie in an $\ell_2$ ball.




**Lasso** replaces the $\ell_2$ penalty in ridge with an $\ell_1$ penalty, which encourages sparse solutions (many coefficients exactly zero):
$$
\widehat{\beta}_{lasso}(\lambda) = \arg\min_{\beta\in\mathbb{R}^p}
\Big\{ \frac{1}{2n} \|Y-X\beta\|_2^2+\lambda\|\beta\|_1\Big\},
\qquad \lambda\ge 0,
$$
where $\|\beta\|_1=\sum_{j=1}^p |\beta_j|$.


The lasso problem is also equivalent (for a suitable mapping between $\lambda$ and $t$) to the constrained form
$$
\min_{\beta}\ \frac{1}{2n}\|Y-X\beta\|_2^2
\quad \text{s.t.}\quad \|\beta\|_1\le t.
$$

**Remark**: Intercept. One typically does not penalize the intercept; writing $Y=\alpha\mathbf{1}_n+X\beta+e$,
$$
(\widehat{\alpha},\widehat{\beta}) = \arg\min_{\alpha,\beta}
\Big\{\frac{1}{2n}\|Y-\alpha\mathbf{1}_n-X\beta\|_2^2+\lambda\|\beta\|_1\Big\}.
$$
The FWL theorem holds for lasso. That is, the estimated coefficients of the included regressors are the same whether we estimate the full model without penalize the intercept, or first to sample demeaning for each variable of $Y$ and $X$, and then throw them into the penalized optimization. The same FWL theorem holds for ridge regression.

Another issue is the **scaling** of regressors.

## Ridge

The ridge objective is strictly convex for $\lambda>0$, and the minimizer is unique. The first-order condition yields
$$
\widehat{\beta}_{ridge}(\lambda)
= \left(\frac{1}{n}X'X + \lambda I_p\right)^{-1}\left(\frac{1}{n}X'Y\right)
$$
Unlike OLS, this expression is well-defined for $\lambda>0$ even when $X'X$ is singular (e.g., $p>n$), because $X'X+n\lambda I_p$ is invertible.


Assume the linear model $Y=X\beta+e$ and the mean independence condition
$$
E[e|X]=0_n.
$$
Write the ridge estimator as
$$
\begin{align*}
\widehat{\beta}_{ridge}(\lambda) &
= (X'X /n +\lambda I_p)^{-1}X'Y /n \\
& 
= (X'X /n +\lambda I_p)^{-1}X'(X\beta+e)/n \\
&  = S_\lambda \beta + \left(\frac{X'X}{n}+ \lambda I_p \right)^{-1} \frac{X'e}{n},
\end{align*}
$$
where the **shrinkage matrix** $S_\lambda := \left(\frac{X'X}{n}+\lambda I_p\right)^{-1} \frac{X'X}{n}.$

The first term is concerning the bias, and the second term characterizes the variance. 

### Bias

Taking conditional expectations, $ E[\widehat{\beta}_{ridge}(\lambda)\mid X] = S_\lambda \beta.$ Therefore the conditional bias is
$$
\begin{align*}
\mathrm{Bias}(\widehat{\beta}_{ridge}(\lambda)\mid X)& 
:=E[\widehat{\beta}_{ridge}(\lambda)\mid X]-\beta
= (S_\lambda-I_p)\beta.
\end{align*}
$$

Diagonalize the Gram matrix 
$$
X'X / n = VDV', \qquad D=\mathrm{diag}(d_1,\ldots,d_p), \qquad d_j\ge 0,
$$

We obtain 
$$
S_\lambda =  (V D V'+ \lambda I_p)^{-1} V D V' =
V\,\mathrm{diag}\!\left(\frac{d_1}{d_1+ \lambda},\ldots,\frac{d_p}{d_p+ \lambda}\right)V'.
$$
Thus ridge shrinks the component of $\beta$ along the $j$th eigenvector by the factor $d_j/(d_j+ \lambda)\in[0,1)$, with stronger shrinkage in low-variance (small $d_j$) directions. 
As a result, the bias comes from
$$
S_\lambda - I_p 
= -  V\,\mathrm{diag}\!\left(\frac{\lambda }{d_1+\lambda},\ldots,\frac{ \lambda }{d_p+\lambda}\right)V' 
= -  \lambda \cdot V D_{\lambda}^{-1} V', 
$$
where $D_\lambda := D + \lambda I_p$. The squared bias is 
$$
\begin{align*}
\|\mathrm{Bias}(\widehat{\beta}_{ridge}(\lambda)\mid X)\|_2^2
&
= \lambda^2\|D_\lambda^{-1}V'\beta\|_2^2
= \sum_{j=1}^p \left(\frac{\lambda}{d_j+\lambda}\right)^2 \tilde\beta_j^2,
\end{align*}
$$
where $\tilde\beta := V'\beta$.


### Variance

Assume **homoskedasticity**:
$$
\mathrm{var}(e\mid X)=E[ee'\mid X]=\sigma^2 I_n.
$$
The conditional variance is
$$
\begin{align*}
\mathrm{var}(\widehat{\beta}_{ridge}(\lambda)\mid X)
&=\mathrm{var}\!\left( \left(\frac{X'X}{n} +\lambda I_p \right)^{-1} \frac{X'e}{n} \mid X\right)\\
&= \frac{\sigma^2}{n} \left( \frac{X'X}{n} + \lambda I_p \right)^{-1}  \frac{X'X}{n} \left( \frac{X'X}{n} + \lambda I_p \right)^{-1} \\
& = \frac{\sigma^2}{n} V  D_{\lambda}^{-1} D D_{\lambda}^{-1} V' \\
&  = \frac{\sigma^2}{n} \,V\,\mathrm{diag}\!\left(\frac{d_1}{(d_1+\lambda)^2},\ldots,\frac{d_p}{(d_p+\lambda)^2}\right)V'.
\end{align*}
$$

###  Bias-Variance Tradeoff 

Ridge trades off squared bias against variance. From above, as $\lambda$ increases, the bias magnitude increases (more shrinkage toward zero), while the variance decreases (less sensitivity to noise, especially along ill-conditioned directions).

$$
\begin{align*}
E[\| \widehat{\beta}_{ridge}(\lambda) - \beta \|^2] & = E[\| \widehat{\beta}_{ridge}(\lambda) - E[\widehat{\beta}_{ridge}(\lambda)] + E[\widehat{\beta}_{ridge}(\lambda)] - \beta \|^2] \\
& = E[\| \widehat{\beta}_{ridge}(\lambda) - E[\widehat{\beta}_{ridge}(\lambda)]\|^2] + E[\|E[\widehat{\beta}_{ridge}(\lambda)] - \beta \|^2] \\
& = \mathrm{variance} + \mathrm{bias}^2 \\
& = \sum_{j=1}^p \frac{\lambda^2}{ (d_j+\lambda)^2} \tilde\beta_j^2 + \frac{\sigma^2}{n} \sum_{j=1}^p \frac{d_j}{(d_j+\lambda)^2}
\end{align*}
$$
When $\lambda \to 0$, the bias term goes to 0 and the variance term goes to $\frac{\sigma^2}{n} \sum_{j=1}^p d_j$. If $p$ is fixed, $\tilde\beta_j \asymp 1$ and $d_j \asymp 1$ for all $j$, the order of the squared bias is $O(\lambda^2)$ and the order of the variance is $O(n^{-1})$. To make the bias of the same order as the variance, we need $\lambda \asymp n^{-1/2}$. 

**Remark**: The calculation of the MSE implies that OLS is consistent in $\| \hat{\beta} - 
\beta \| \stackrel{p}{\rightarrow} 0 $ if $p/n \to 0$.

## Lasso


### KKT conditions

Because the $\ell_1$ norm is not differentiable at zero, we write first-order optimality using **subgradients**. Consider the (no-intercept, centered) lasso problem
$$
\min_{\beta\in\mathbb{R}^p}\ f(\beta):=\frac{1}{2n}\|Y-X\beta\|_2^2+\lambda\|\beta\|_1.
$$
Let $\widehat{\beta}$ be a solution and define residuals $\widehat e := Y-X\widehat\beta$. The KKT (stationarity) condition is
$$
0 \in \partial f(\widehat\beta)
\quad\Longleftrightarrow\quad
\frac{1}{n}X'(X\widehat\beta-Y)+\lambda s = 0
\quad\Longleftrightarrow\quad
\frac{1}{n}X'\widehat e = \lambda s,
$$
where $s\in\partial\|\widehat\beta\|_1$ is a subgradient of the $\ell_1$ norm. Component-wise,
$$
s_j=
\begin{cases}
\mathrm{sign}(\widehat\beta_j) & \text{if }\widehat\beta_j\neq 0,\\
u,\ \ u\in[-1,1] & \text{if }\widehat\beta_j=0.
\end{cases}
$$
Equivalently, for each regressor $j$,
$$
\widehat\beta_j\neq 0 \ \Rightarrow\ \frac{1}{n}x_j'\widehat e = \lambda\,\mathrm{sign}(\widehat\beta_j),
\qquad
\widehat\beta_j=0 \ \Rightarrow\ \left|\frac{1}{n}x_j'\widehat e\right|\le \lambda,
$$
where $x_j$ denotes column $j$ of $X$.

Lasso sets $\widehat\beta_j=0$ whenever the (absolute) sample covariance $\left|\frac{1}{n}x_j'\widehat e\right|$ is not large enough to overcome the threshold $\lambda$. The active set consists of regressors whose covariance with the residual hits the boundary.


## Restricted Eigenvalue Condition

When $p$ is large (possibly $p>n$), $X'X$ is singular so the usual smallest-eigenvalue condition cannot hold. Lasso theory instead uses eigenvalue conditions that only need to hold on **sparse directions**.

Let the (sample) Gram matrix be
$$
\widehat\Sigma := \frac{1}{n}X'X.
$$
For an index set $S\subset\{1,\ldots,p\}$ and a constant $c_0\ge 1$, define the cone
$$
\mathcal{C}(S,c_0):=\left\{\delta\in\mathbb{R}^p:\ \|\delta_{S^c}\|_1\le c_0\|\delta_S\|_1\right\}.
$$

We say $X$ satisfies the **restricted eigenvalue condition** with sparsity level $s$ and constant $\kappa(s,c_0)>0$ if for all sets $S$ with $|S|\le s$ and all $\delta\in\mathcal{C}(S,c_0)\setminus\{0\}$,
$$
\delta'\widehat\Sigma\,\delta \ \ge\ \kappa(s,c_0)^2\,\|\delta_S\|_2^2.
$$
Equivalently,
$$
\kappa(s,c_0):=\min_{|S|\le s}\ \min_{\delta\in\mathcal{C}(S,c_0)\setminus\{0\}}
\frac{\sqrt{\delta'\widehat\Sigma\,\delta}}{\|\delta_S\|_2}.
$$

**Why it matters.** The RE condition prevents strong collinearity *among sparse combinations of regressors*. It is a standard assumption used to derive lasso error bounds such as $\|\widehat\beta-\beta\|_2$ and $\|\widehat\beta-\beta\|_1$ rates, and to justify variable selection results under additional assumptions.

## Consistency of Lasso

### Step 1: Basic inequality 

Optimality implies the **basic inequality**
$$
\frac{1}{2n}\|Y-X\widehat\beta\|_2^2+\lambda\|\widehat\beta\|_1
\le
\frac{1}{2n}\|Y-X\beta_0\|_2^2+\lambda\|\beta_0\|_1.
$$
Substitute $Y=X\beta_0+e$ and expand to obtain
$$
\frac{1}{2n}\|X\Delta\|_2^2
\le
\frac{1}{n}e'X\Delta+\lambda(\|\beta_0\|_1-\|\widehat\beta\|_1).
$$
where $\Delta:=\widehat\beta-\beta_0$ is the estimation error. Bound the stochastic term using Holder's inequality:
$$
\frac{1}{n}e'X\Delta \le \left\|\frac{1}{n}X'e\right\|_\infty \|\Delta\|_1.
$$
Choose $\lambda$ so that $\lambda \ge 2\left\|\frac{1}{n}X'e\right\|_\infty.$ (The constant 2 is chosen for convenience (with $c_0 = 3$.) The proof works for any constant $\leq 1$.) Then the inequality becomes
$$
\frac{1}{2n}\|X\Delta\|_2^2
\le
\frac{\lambda}{2}\|\Delta\|_1+\lambda(\|\beta_0\|_1-\|\widehat\beta\|_1).
$$
Using $\|\beta_0\|_1-\|\widehat\beta\|_1 \le \|\Delta_S\|_1-\|\Delta_{S^c}\|_1$, we get
$$
\frac{1}{2n}\|X\Delta\|_2^2
\le
\frac{3\lambda}{2}\|\Delta_S\|_1-\frac{\lambda}{2}\|\Delta_{S^c}\|_1.
$$
Since the left-hand side is nonnegative, this implies the **cone condition** $
\|\Delta_{S^c}\|_1 \le 3\|\Delta_S\|_1,
$ so $\Delta\in\mathcal{C}(S,3)$.

### Step 2: Apply the RE condition

Under the RE condition with $c_0=3$, we have 
$$
\frac{1}{n}\|X\Delta\|_2^2 = 
\Delta'\widehat\Sigma\,\Delta \ge \kappa(s,3)^2\|\Delta_S\|_2^2.
$$
Combine with Step 1 and the Cauchy-Schwarz inequality $\|\Delta_S\|_1\le \sqrt{s}\|\Delta_S\|_2$:
$$
\kappa(s,3)^2\|\Delta_S\|_2^2
\le
\frac{1}{n}\|X\Delta\|_2^2
\le
3\lambda\|\Delta_S\|_1
\le
3\lambda\sqrt{s}\|\Delta_S\|_2.
$$
Hence $\|\Delta_S\|_2 \le \frac{3\lambda\sqrt{s}}{\kappa(s,3)^2}.
$ Moreover, from Step 1,
$$
\frac{1}{n}\|X\Delta\|_2^2 \le 3\lambda\|\Delta_S\|_1 \le 9\frac{\lambda^2 s}{\kappa(s,3)^2},
$$
and also
$$
\|\Delta\|_1 \le 4\|\Delta_S\|_1 \le 12\frac{\lambda s}{\kappa(s,3)^2}.
$$

### Step 3: Conclude consistency by choosing a proper $\lambda_n$

Under standard tail conditions (e.g., sub-Gaussian errors and normalized columns), one can show
$$
\left\|\frac{1}{n}X'e\right\|_\infty = O_p\!\left(\sqrt{\frac{\log p}{n}}\right),
$$
so there exists a constant $C$ such that if we set $\lambda = \lambda_n = C \sqrt{\frac{\log p}{n}}$, the needed condition in Step 1 holds with high probability. Then the bounds above yield
$$
\frac{1}{n}\|X(\widehat\beta-\beta_0)\|_2^2 = O_p\!\left(\frac{s\log p}{n}\right),
\qquad
\|\widehat\beta-\beta_0\|_1 = O_p\!\left(s\sqrt{\frac{\log p}{n}}\right),
$$
and therefore lasso is **prediction consistent** if $s\log p/n \to 0$ and $\kappa(s,3)$ is bounded away from zero. Moreover, if $s\sqrt{\log p/n}\to 0$ then $\|\widehat\beta-\beta_0\|_1\to 0$ in probability, and if $s$ is fixed (or grows very slowly) then $\|\widehat\beta-\beta_0\|_2\to 0$ as well.

### Adaptive Lasso

Adaptive lasso is a **weighted** $\ell_1$-penalized least squares problem:
$$
\widehat{\beta}_{AL}(\lambda) = \arg\min_{\beta\in\mathbb{R}^p}
\Big\{ \frac{1}{2n} \|Y-X\beta\|_2^2+\lambda\sum_{j=1}^p w_j|\beta_j|\Big\},
\qquad \lambda\ge 0,
$$
where the weights $w_j>0$ are constructed from an initial estimator $\widetilde\beta$ (e.g., OLS when $p\ll n$, or ridge otherwise). A common choice is $w_j=1/|\widetilde\beta_j|.$


## Double Machine Learning

Consider a regression
$$
y = d\theta_0 + w'\eta_0 + u 
$$
where $d$ is the regressor of interest and $w$ is a control vector. Thus $\theta$ is the **parameter of interest** and $\eta$ is **nuisance parameter**. 

**Neyman orthogonality** looks for a score function $\psi( \theta, \eta; \text{data}_i) =\psi( \theta, \eta) $ such that 
$$
E[\psi(\theta,\eta)]=0,\qquad (\theta_0,\eta_0)\text{ solves }E[\psi(\theta_0,\eta_0)]=0.
$$
If we plug in an estimate $\widehat\eta$, then (heuristically) a first-order expansion around $\eta_0$ gives
$$
E[\psi(\theta_0,\widehat\eta)] =E[\psi(\theta_0,\eta_0)]
+\partial_\eta E[\psi(\theta_0,\eta)]\big|_{\eta=\eta_0}\,(\widehat\eta-\eta_0)
+\text{higher-order terms}.
$$
Since $E[\psi(\theta_0,\eta_0)]=0$, the leading bias term is proportional to the derivative $\partial_\eta E[\psi(\theta_0,\eta)]|_{\eta_0}$ times the nuisance error.

If we choose $\psi$ so that this derivative 
$$
\partial_\eta E[\psi(\theta_0,\eta)]\big|_{\eta=\eta_0}=0.
$$
Then the effect of nuisance estimation is only **second order**, so even a relatively slow (but consistent) ML estimator of $\eta_0$ can be good enough to get
$$
\sqrt n(\widehat\theta-\theta_0)\Rightarrow N(0,\cdot).
$$

Specifically, in the linear regression model we construct
$$
\psi(\theta, \eta) = \tilde{d} \cdot (y - \tilde d \theta)
$$
where $\tilde d = d - w' \gamma_d$. It is easy to verify that $$
E[ \psi(\theta_0, \eta_0)]  = E[\tilde{d} \cdot (y - \tilde d \theta)] \big|_{\theta = \theta_0} = 0
$$ by the FWL theorem. 
Notice that $y$ depend on $(\theta, \eta)$ and $\frac{\partial y}{\partial \eta} = w.$  We verify
$$
\partial_{\eta} E[\psi (\theta_0, \eta)] \big|_{\eta = \eta_0} 
= E[  \tilde{d} \cdot  \frac{\partial y}{\partial \eta}    ] \big|_{\eta = \eta_0} 
= E[  \tilde{d} \cdot w  ] = 0.
$$

In high-dimensional settings we estimate nuisance components by machine learning methods such as lasso. These nuisance estimators typically converge more slowly than $n^{-1/2}$, so a naive plug-in estimator for $\theta$ can inherit **first-order bias** from nuisance estimation error.
DML constructs an orthogonal score so that small errors in estimating the high-dimensional nuisance components have only second-order effects on inference for $\theta$.


Neyman orthogonality is true if we specify $\psi(\theta, \eta) = \tilde{d} \cdot ( \tilde y - \tilde d \theta)$, where $\tilde y = y - w' \gamma_y$ is the (population) regression residual. 
In this case, we also want to run lasso of $y$ on $w$ to get rid of the influence from high-dimensionality. That's where the name "double ML" refers to.

