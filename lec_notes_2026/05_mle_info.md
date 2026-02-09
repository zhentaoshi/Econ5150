# Likelihood


## Multinomial Distribution

**Definition**: For a multinomial random variable $p=(p_1,\ldots,p_J)$ on $\{1,\ldots,J\}$, its **entropy** is 
$$
H(p)= - \sum_{j=1}^J p_j \log p_{j} = \sum_{j=1}^J p_j \log \frac{1}{p_{j}} .
$$


It is the *average surprise* (information content) of an outcome drawn from $p$: it is largest when outcomes are most unpredictable (uniform $p_j=1/J$) and smallest when outcomes are most predictable (all mass on one point).


**Shannon's interpretation (source coding).** Think of $Y$ as a message source that emits symbol $j$ with probability $p_j$. If we encode each realization using an optimal binary prefix code, then the *smallest achievable average* number of bits per symbol is essentially the entropy: $H(p)\le \bar L < H(p)+1$ (when $\log$ is base 2). For example, a fair coin has $p=(1/2,1/2)$ and $H(p)=1$ bit (about 1 bit per flip), while a biased coin with $p=(0.9,0.1)$ has $H(p)\approx 0.469$ bits (fewer bits on average because outcomes are more predictable).



### MLE


Let $y_i$ follow a multinomial distribution with $J$ discrete points on its support. $(y_1,\ldots, y_n)$ is a sample of $n$ observations. The maximum likelihood estimation is 
$$\widehat p_j=\arg\max_{p_j\ge 0,\ \sum_{k=1}^J p_k=1}\ \prod_{k=1}^J p_k^{n_k}=\frac{n_j}{n},\qquad n_j:=\sum_{i=1}^n \mathbf{1}\{y_i=j\},\ \ j=1,\ldots,J.$$

Step-by-step derivation:

1. Let $p=(p_1,\ldots,p_J)$ with $p_j\ge 0$ and $\sum_{j=1}^J p_j=1$. Define counts $n_j:=\sum_{i=1}^n \mathbf{1}\{y_i=j\}$, so $\sum_{j=1}^J n_j=n$.
2. The likelihood is
   $$
   L(p)=\prod_{i=1}^n p_{y_i}=\prod_{j=1}^J p_j^{n_j}.
   $$
3. The log-likelihood is (use $1/n$ to standardize, without loss of generality)
   $$
   \ell_n(p)= \frac{1}{n} \sum_{j=1}^J n_j\log p_j.
   $$
4. Form the Lagrangian for the simplex constraint:
   $$
   \mathcal{L}_n(p,\lambda)= \frac{1}{n}  \sum_{j=1}^J n_j\log p_j+\lambda\Big(1-\sum_{j=1}^J p_j\Big).
   $$
5. First-order conditions give, for each $j$,
   $$
   \frac{\partial \mathcal{L}_n}{\partial p_j}=\frac{n_j}{n p_j}-\lambda=0
   \quad\Longrightarrow\quad
   p_j=\frac{n_j}{ n \lambda}.
   $$
6. Impose $\sum_{j=1}^J p_j=1$:
   $$
   1=\sum_{j=1}^J \frac{n_j}{ n \lambda}=\frac{1}{\lambda}
   \quad\Longrightarrow\quad
   \lambda=1.
   $$
7. Therefore $\widehat p_j=n_j/n$ for $j=1,\ldots,J$ (and $\widehat p_j\ge 0$ automatically since $n_j\ge 0$).

Given the MLE $\widehat p_j=n_j/n$, we have the identity
$$
-\ell_n(\widehat p)= -\sum_{j=1}^J \frac{n_j}{n}\log\Big(\frac{n_j}{n}\Big)=:H(\widehat p),
$$
the **plug-in entropy** of the empirical frequencies. By the law of large numbers $\widehat p_j=n_j/n\to_p p_{j}$. By the continuous mapping theorem,  $H(\widehat p)\to_p H(p)$.


For a candidate pmf $q=(q_1,\ldots,q_J)$ and true pmf $p=(p_1,\ldots,p_J)$, the **cross-entropy** of $(p,q)$ is
$$
H(p,q):=-\sum_{j=1}^J p_j\log q_j\;.
$$


**Claim.** $H(p)$ is a lower bound of $H(p,q)$ (assume $q_j>0$ whenever $p_j>0$). Indeed,
$$
H(p,q)-H(p)
=\Big(-\sum_{j=1}^J p_j\log q_j\Big)-\Big(-\sum_{j=1}^J p_j\log p_j\Big)
=\sum_{j=1}^J p_j\log\frac{p_j}{q_j} \ge 0,
$$
so $H(p,q)\ge H(p)$, with equality iff $q=p$.

**Definition**: **Kullback-Leibler divergence** 
$$
D_{\mathrm{KL}}(p\|q) = H(p,q)-H(p)
$$
measures how well a candidate distribution $q$ approximates a target distribution $p$. It has the following basic properties.

1. (**Nonnegativity**) $D_{\mathrm{KL}}(p \| q )\ge 0$ whenever it is well-defined.
2. (**Zero iff equality**) $D_{\mathrm{KL}}(p \|  q)=0$ iff $p=q$ (a.s. on the support).
3. (**Asymmetry**) In general $D_{\mathrm{KL}}(p\|q)\neq D_{\mathrm{KL}}(q\|p)$, so it is not a distance metric.

## Continuous Distribution

If $Y$ has density $p$ on $\mathbb{R}^d$, its **differential entropy** is
$$
h(p):=-\int p(y)\log p(y)\,dy \;=\; E_p[-\log p(Y)].
$$
Unlike the discrete entropy $H(p)$, differential entropy (i) can be negative, and (ii) depends on the measurement scale/units (it is not invariant to one-to-one reparameterizations; e.g. if $Z=aY$ then $h(Z)=h(Y)+\log|a|$). A useful link is that if you discretize $Y$ using bins of width $\Delta$, then the discrete entropy of the binned variable satisfies $H_\Delta(Y)\approx h(Y)+\log(1/\Delta)$ for small $\Delta$.

### Parametric family and Model specification

Let $\{f_\theta:\theta\in\Theta\}$ be a parametric family (pmf or density). Given i.i.d. data $Y_1,\ldots,Y_n$, the likelihood and log-likelihood are
$$
L_n(\theta)=\prod_{i=1}^n f_\theta(Y_i),\qquad 
\ell_n(\theta)= \frac{1}{n} \sum_{i=1}^n \log f_\theta(Y_i),
$$
and the **MLE** is $\widehat\theta = \arg\max_{\theta\in\Theta}\ell_n(\theta)$.

*Example (Normal).* If $Y_i\stackrel{iid}{\sim}N(\mu,\sigma^2)$, then $\widehat\mu=\bar Y$ and $\widehat\sigma^2=\frac{1}{n}\sum_{i=1}^n (Y_i-\bar Y)^2$.


Let $p_0$ denote the true pmf/density of $Y$ and let $\{f_\theta:\theta\in\Theta\}$ be the parametric model. By the law of large numbers,
$$
\ell_n(\theta)=\frac{1}{n}\sum_{i=1}^n \log f_\theta(Y_i)\ \to_p\ E_{p_0}[\log f_\theta(Y)].
$$
Using the identity
$$
E_{p_0}[\log f_\theta(Y)]
=E_{p_0}[\log p_0(Y)]-D_{\mathrm{KL}}(p_0\|f_\theta),
\qquad
D_{\mathrm{KL}}(p_0\|f_\theta):=E_{p_0}\!\left[\log\frac{p_0(Y)}{f_\theta(Y)}\right],
$$
maximizing expected log-likelihood is equivalent to **minimizing KL divergence** from the truth to the model.

- **Correct specification.** If $p_0=f_{\theta_0}$ for some $\theta_0$, then $D_{\mathrm{KL}}(p_0\|f_{\theta_0})=0$ and $\theta_0$ minimizes $D_{\mathrm{KL}}(p_0\|f_\theta)$.
- **Misspecification.** If $p_0\notin\{f_\theta\}$, MLE targets the **pseudo-true parameter**
$$
\theta^\ast:=\arg\min_{\theta\in\Theta} D_{\mathrm{KL}}(p_0\|f_\theta).
$$

### Score and Fisher information

Write the log-likelihood contribution as $\ell_i(\theta):=\log f_\theta(Y_i)$.

- (**Score**) $s_i(\theta):=\nabla_\theta \ell_i(\theta)$ and the sample score $S_n(\theta):=\nabla_\theta \ell_n(\theta)=\frac{1}{n}\sum_{i=1}^n s_i(\theta)$.

Historically, Fisher used *score* in the sense of "to score" how well the parameter value fits observations. Since $S_n(\theta)$ is the gradient, its sign and magnitude tell you the direction and strength of local improvement. From the perspective of optimization in the population model, 
$$E_{\theta^*}[S_n(\theta^*)]=0$$ at the pseudo-true parameter $\theta^*$.

Most MLE estimation is implemented numerically. Suppose $\theta_t$ is a current point of numerical evaluation, then a Taylor expansion to the first order is 
$$
\ell_n(\hat \theta) = \ell_n(\theta_t ) + (\hat\theta -  \theta_t)' S_n(\theta_t) + h.o.t.
$$
A necessary condition for achieving optimization is when $S_n (\theta_t ) \approx 0$.



**Remark** In double machine learning (DML), the word *score* is used more broadly to mean an estimating equation (moment function) $\psi(W;\theta,\eta)$, where $\theta$ is the low-dimensional target parameter and $\eta$ are high-dimensional nuisance functions (learned by ML). The DML estimator solves the sample analogue
$$
\frac{1}{n}\sum_{i=1}^n \psi(W_i;\theta,\widehat\eta)=0.
$$
Crucially, DML uses a **Neyman-orthogonal score** satisfying $\nabla_\eta E[\psi(W;\theta_0,\eta)]\big|_{\eta=\eta_0}=0$, which makes the estimating equation insensitive (to first order) to small errors in $\widehat\eta$; cross-fitting is then used to reduce overfitting bias.




The variance of the score function is $I(\theta):=E_\theta[s_i(\theta)s_i(\theta)']$. If the model is correctly specified, $I(\theta_0)$ is called the **Fisher information**. Under standard regularity conditions, the **information equality** holds:
$$
I(\theta_0)= -E_{\theta_0}\!\left[\nabla_\theta^2 \ell_i(\theta_0)\right].
$$

