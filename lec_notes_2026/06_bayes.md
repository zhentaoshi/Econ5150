# Bayesian School

Bayesian is a philosophical view of uncertainty. The depth of the idea makes it difficult to be conveyed in class. That is why university statistics education is dominated by the frequentist school. Bayesian and frequentist statistics both accept the likelihood function. 

In the Bayesian view, probability quantifies uncertainty given information. A probability statement is an expression of belief. Inference is a process of updating beliefs in a logically consistent way when new data arrive.

Bayesian: 君子和而不同. One writes a prior distribution for an unknown parameter, $p(\theta)$, and updates it using Bayes' rule after observing data $y$:

$$
p(\theta\mid y) \propto p(y\mid \theta)\,p(\theta).
$$

The posterior $p(\theta\mid y)$ is a probability about $\theta$ given the data and the prior.

A **Bayesian 95% credible interval** $C(y)$ satisfies $\Pr(\theta \in C(y)\mid y)=0.95$ under the posterior. The probability statement is *about the parameter* conditional on the observed data and the prior/model.


## Bayesian Decision Theory

Bayesian approach provides a direct rule for choosing actions under uncertainty. The key ingredients are (i) an **action** $a$ in some action space $\mathcal{A}$ (e.g., a point estimate, a forecast, a classification decision, a policy choice), (ii) a **loss function** $L(a,\theta)$ that measures the cost of taking action $a$ when the true parameter (or state) is $\theta$.

Given data $y$, Bayesian decision theory evaluates actions using the **posterior expected loss**
$$
\rho(a\mid y):=\mathbb{E}[L(a,\theta)\mid y]=\int L(a,\theta)\,p(\theta\mid y)\,d\theta,
$$
and chooses the **Bayes action**
$$
a^\ast(y) = \arg\min_{a\in\mathcal{A}} \rho(a\mid y).
$$
This highlights an important separation: the posterior summarizes uncertainty, while the loss function encodes the application's objectives and tradeoffs.

Many familiar "point estimates" are Bayes actions under particular loss functions.

- (**Squared error**) If $\mathcal{A}=\mathbb{R}$ and $L(a,\theta)=(a-\theta)^2$, then $a^\ast(y)=\mathbb{E}[\theta\mid y]$ (posterior mean).
- (**Absolute error**) If $L(a,\theta)=|a-\theta|$, then $a^\ast(y)$ is a posterior median.
- (**0-1 loss**) If $\theta$ takes discrete values and $L(a,\theta)=\mathbf{1}\{a\neq \theta\}$, then $a^\ast(y)$ is a MAP choice: pick the value of $\theta$ with highest posterior probability.

When the decision is about a future outcome $\tilde y$, Bayesian decision theory then uses the posterior predictive distribution
$$
p(\tilde y\mid y)=\int p(\tilde y\mid \theta)\,p(\theta\mid y)\,d\theta.
$$

### The Frequentist View

In the frequentist view, probability is a property of a data-generating process under hypothetical repetition. A probability statement refers to the *long-run relative frequency* of events if the same experiment (or sampling procedure) were repeated indefinitely under the same conditions.The unknown parameter $\theta$ is fixed; randomness comes from the sampling process that generates $Y$.



A **frequentist 95% confidence interval** $C(Y)$ satisfies $\Pr_\theta(\theta \in C(Y))=0.95$ under the sampling distribution when the true parameter equals $\theta$. The probability statement is *about the random interval* across repeated samples.

Frequentist decision theory evaluates a decision rule $\delta(Y)$ via its **risk function** $R(\theta,\delta)=\mathbb{E}_\theta[L(\delta(Y),\theta)]$ under repeated sampling when the true parameter equals $\theta$. The Bayesian counterpart replaces the sampling-based objective with posterior conditioning and (optionally) averages risk over a prior. In this sense, Bayesian decision theory is naturally "conditional on the observed data," while frequentist criteria are often framed as long-run properties of procedures.

## Example: Bayesian Logistic Regression

Logistic regression is a clean example because the likelihood is familiar and the Bayesian workflow is explicit, but the posterior is typically not available in closed form (so computation matters).

### Step 1: Specify the likelihood

Let $(y_i,x_i)$ for $i=1,\ldots,n$ be data with $y_i\in\{0,1\}$ and regressors $x_i\in\mathbb{R}^p$. Let the parameter be $\theta\in\mathbb{R}^p$. The logistic model is
$$
\Pr(y_i=1\mid x_i,\theta)=\sigma(x_i'\theta),\qquad \sigma(t):=\frac{1}{1+e^{-t}}.
$$
Equivalently,
$$
y_i\mid x_i,\theta\sim\mathrm{Bernoulli}(\sigma(x_i'\theta)).
$$
The likelihood is
$$
p(y\mid \theta)=\prod_{i=1}^n \sigma(x_i'\theta)^{y_i}\big(1-\sigma(x_i'\theta)\big)^{1-y_i}.
$$

### Step 2: Choose a prior for $\theta$

A common default is a mean-zero Gaussian prior,
$$
\theta\sim N(0,\tau^2 I_p),
$$
which encodes shrinkage toward 0 and helps stabilize estimation in high dimensions or with separation.

### Step 3: Bayes' rule

Bayes' rule gives the posterior up to proportionality:
$$
p(\theta\mid y)\propto p(y\mid \theta)\,p(\theta).
$$
Taking logs, the log-posterior is
$$
\log p(\theta\mid y)=\sum_{i=1}^n\Big(y_i\log\sigma(x_i'\theta)+(1-y_i)\log\big(1-\sigma(x_i'\theta)\big)\Big)-\frac{1}{2\tau^2}\theta'\theta + \text{const}.
$$
For logistic regression, this posterior generally does not simplify to a standard distribution.

### Step 4: Compute the posterior

In practice, we use numerical methods such as Markov Chain Monte Carlo (MCMC) to draw $\theta^{(1)},\ldots,\theta^{(S)}\sim p(\theta\mid y)$ approximately; alternatives include Laplace approximations and variational inference. The posterior summaries include posterior means/medians, marginal credible intervals for components of $\theta$, and functionals such as predicted probabilities. 

For a new covariate vector $\tilde x$, the posterior predictive success probability is
$$
\Pr(\tilde y=1\mid \tilde x,y)=\int \sigma(\tilde x'\theta)\,p(\theta\mid y)\,d\theta,
$$
which can be approximated by Monte Carlo using posterior draws:
$$
\Pr(\tilde y=1\mid \tilde x,y)\approx \frac{1}{S}\sum_{s=1}^S \sigma(\tilde x'\theta^{(s)}).
$$

See `code/bayes-logistic.ipynb` as an example to implement the above procedure.

## Variational Inference

For many Bayesian models, exact posterior calculations are infeasible and MCMC may be computationally expensive in large datasets or high dimensions. **Variational inference (VI)** is an optimization-based alternative: it approximates the posterior $p(\theta\mid y)$ by a simpler distribution $q(\theta)$ chosen from a tractable family.

### ELBO

Choose a variational family $\mathcal{Q}$ and solve
$$
q^\ast \in \arg\min_{q\in\mathcal{Q}} \mathrm{KL}\big(q(\theta)\,\|\,p(\theta\mid y)\big),
$$
where $\mathrm{KL}(q\|p):=\int q(\theta)\log\frac{q(\theta)}{p(\theta)}\,d\theta$.

This is equivalent to maximizing the **evidence lower bound (ELBO)**:
$$
\mathrm{ELBO}(q):=\mathbb{E}_q[\log p(y,\theta)]-\mathbb{E}_q[\log q(\theta)].
$$
where the joint density $p(y,\theta)=p(y\mid \theta)p(\theta)$ explicit depends on the prior.

### Practical workflow

In practice, VI proceeds as follows:

1. Specify a prior $p(\theta)$ (and hyperparameters) and a variational family $\mathcal{Q}$ (e.g., mean-field Gaussian $q(\theta)=N(\mu,\Sigma)$ with diagonal $\Sigma$).
2. Write down (or estimate) $\mathrm{ELBO}(q)$, which always depends on both the likelihood and the prior through $p(y,\theta)$.
3. Optimize the ELBO over variational parameters (e.g., $\mu,\Sigma$) using coordinate ascent (when available) or stochastic gradient methods.

In modern machine learning, VI is often implemented with stochastic gradients and minibatches, and it supports **amortized inference** (learning a map from data to variational parameters) in latent-variable models. VI typically delivers fast approximate posterior means and predictive distributions, but the quality of the approximation depends on both the chosen variational family and the prior/model specification.

The key for fast approximation is that we do not sample from the prior distribution $p(\theta)$. Instead, sampling comes from the specified $q(\theta)$. The implementation is very similar to EM algorithm.

## Conclusion

Bayesian methods provide a coherent framework for learning and decision-making under uncertainty: start with a prior, update with data through the likelihood, and use the posterior (or posterior predictive) to make decisions that reflect explicit loss tradeoffs. Compared with frequentist methods, the core difference is interpretive: Bayesian inference assigns probability to unknown parameters conditional on observed data and modeling assumptions, while frequentist inference evaluates procedures through repeated-sampling performance. In practice, Bayesian tools are especially useful when uncertainty quantification, regularization, and sequential decisions matter. The logistic regression example illustrates the full workflow from model specification to posterior prediction, and the discussion of MCMC versus variational inference highlights the key computational tradeoff between fidelity and speed.
