# Bayesian Methods

At a high level, Bayesian and frequentist statistics share a lot of the same mathematical machinery (likelihoods, models, and asymptotics). The deepest difference is conceptual: what a probability statement is allowed to mean, and therefore what counts as uncertainty about unknown objects.

### The Bayesian View

In the Bayesian view, probability quantifies *uncertainty given information*. A probability statement is an expression of rational belief that is conditioned on what you know. Inference is then a process of updating beliefs in a logically consistent way when new data arrive.

- **Uncertainty is personal but disciplined.** Different people may begin with different information (and thus different beliefs), but Bayesian probability imposes *coherence*.
- **Unknown parameters are uncertain objects.** One writes a prior distribution for an unknown parameter, $p(\theta)$, and updates it using Bayes' rule after observing data $y$:

$$
p(\theta\mid y) \propto p(y\mid \theta)\,p(\theta).
$$

The posterior $p(\theta\mid y)$ is a *full probability model for* $\theta$ given the data and the prior information.

- **Conditioning is central.** Bayesian statements are explicitly conditional: "given my model and prior (information set), the probability that $\theta$ lies in this region is 0.95."

## Bayesian Decision Theory

Bayesian inference is not only about learning $p(\theta\mid y)$; it also provides a direct rule for choosing actions under uncertainty. The key ingredients are:

- an **action** $a$ in some action space $\mathcal{A}$ (e.g., a point estimate, a forecast, a classification decision, a policy choice),
- a **loss function** $L(a,\theta)$ that measures the cost of taking action $a$ when the true parameter (or state) is $\theta$.

Given data $y$, Bayesian decision theory evaluates actions using the **posterior expected loss**
$$
\rho(a\mid y):=\mathbb{E}[L(a,\theta)\mid y]=\int L(a,\theta)\,p(\theta\mid y)\,d\theta,
$$
and chooses the **Bayes action**
$$
a^\ast(y)\in\arg\min_{a\in\mathcal{A}} \rho(a\mid y).
$$
This highlights an important separation: the posterior summarizes uncertainty, while the loss function encodes the application's objectives and tradeoffs.

### Estimation as a decision problem

Many familiar "point estimates" are Bayes actions under particular loss functions.

- (**Squared error**) If $\mathcal{A}=\mathbb{R}$ and $L(a,\theta)=(a-\theta)^2$, then $a^\ast(y)=\mathbb{E}[\theta\mid y]$ (posterior mean).
- (**Absolute error**) If $L(a,\theta)=|a-\theta|$, then $a^\ast(y)$ is a posterior median.
- (**0-1 loss**) If $\theta$ takes discrete values and $L(a,\theta)=\mathbf{1}\{a\neq \theta\}$, then $a^\ast(y)$ is a MAP choice: pick the value of $\theta$ with highest posterior probability.

### Prediction and classification (posterior predictive)

Often the decision is about a future outcome $\tilde y$ rather than the parameter itself. Bayesian decision theory then uses the **posterior predictive distribution**
$$
p(\tilde y\mid y)=\int p(\tilde y\mid \theta)\,p(\theta\mid y)\,d\theta.
$$
For binary prediction with asymmetric misclassification costs, the optimal rule is a threshold rule on the predictive probability. For example, predict class 1 when
$$
\Pr(\tilde y=1\mid x,y)>\frac{c_{01}}{c_{01}+c_{10}},
$$
where $c_{01}$ is the loss of predicting 0 when the truth is 1 (a false negative) and $c_{10}$ is the loss of predicting 1 when the truth is 0 (a false positive).

### Relation to frequentist risk

Frequentist decision theory evaluates a decision rule $\delta(Y)$ via its **risk function** $R(\theta,\delta)=\mathbb{E}_\theta[L(\delta(Y),\theta)]$ under repeated sampling when the true parameter equals $\theta$. The Bayesian counterpart replaces the sampling-based objective with posterior conditioning and (optionally) averages risk over a prior. In this sense, Bayesian decision theory is naturally "conditional on the observed data," while frequentist criteria are often framed as long-run properties of procedures.



### The Frequentist View

In the frequentist view, probability is a property of a data-generating process under hypothetical repetition. A probability statement refers to the *long-run relative frequency* of events if the same experiment (or sampling procedure) were repeated indefinitely under the same conditions.

- **Parameters are fixed, data are random.** The unknown parameter $\theta$ is not random; randomness comes from the sampling process that generates $Y$.
- **Uncertainty is about procedures.** A frequentist confidence interval is a random set (because it depends on random data) constructed so that, under repeated sampling at the true $\theta$, it contains $\theta$ with a specified long-run frequency.

### Credible Sets vs Confidence Sets

- A **Bayesian 95% credible interval** $C(y)$ satisfies $\Pr(\theta \in C(y)\mid y)=0.95$ under the posterior. The probability statement is *about the parameter* conditional on the observed data and the prior/model.
- A **frequentist 95% confidence interval** $C(Y)$ satisfies $\Pr_\theta(\theta \in C(Y))=0.95$ under the sampling distribution when the true parameter equals $\theta$. The probability statement is *about the random interval* across repeated samples.

These can numerically look similar in many regular problems (especially in large samples), but the interpretations are logically different.

## How They Relate in Practice

1. **Both start from a model.** Neither approach avoids assumptions: likelihood-based inference requires a data model, and Bayesian inference additionally requires a prior.
2. **The likelihood plays a central role in both.** Many Bayesian posteriors concentrate near frequentist estimators as $n$ grows (under regularity), which helps explain why large-sample Bayesian credible sets can resemble frequentist confidence intervals in well-behaved problems.
3. **Small-sample behavior can differ materially.** Priors can stabilize inference (regularization) or, if poorly chosen, dominate results; frequentist procedures can have exact calibration in certain models (e.g., some finite-sample pivots) but may be unstable in high-dimensional or weakly identified settings.



## Use Cases

Bayesian methods are most useful in machine learning when we want the output of a model to be more than a point prediction. The Bayesian workflow naturally produces a predictive distribution (and thus uncertainty), offers a principled way to regularize complex models, and supports sequential decision-making under uncertainty.

### Uncertainty Quantification

In many applications, we care about *how confident* the model is, not only what it predicts. Bayesian methods target the posterior predictive distribution
$$
p(\tilde y\mid y)=\int p(\tilde y\mid \theta)\,p(\theta\mid y)\,d\theta,
$$
which can be used to produce prediction intervals, quantify uncertainty in derived functionals, and flag out-of-distribution inputs (where predictive uncertainty can rise).

### Regularization and Prior Information

In high-dimensional prediction problems, priors act as structured regularizers. Maximizing the posterior (MAP)
$$
\hat\theta_{\mathrm{MAP}}=\arg\max_\theta\{\log p(y\mid \theta)+\log p(\theta)\}
$$
is equivalent to penalized likelihood, where $-\log p(\theta)$ becomes the penalty. This perspective links common ML regularizers (e.g., ridge-type shrinkage) to specific prior choices.

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

### Step 3: Form the posterior via Bayes' rule

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

In practice, we use numerical methods such as Markov Chain Monte Carlo (MCMC) to draw $\theta^{(1)},\ldots,\theta^{(S)}\sim p(\theta\mid y)$ approximately; alternatives include Laplace approximations and variational inference. The posterior summaries include posterior means/medians, marginal credible intervals for components of $\theta$, and functionals such as predicted probabilities. For a new covariate vector $\tilde x$, the posterior predictive success probability is
$$
\Pr(\tilde y=1\mid \tilde x,y)=\int \sigma(\tilde x'\theta)\,p(\theta\mid y)\,d\theta,
$$
which can be approximated by Monte Carlo using posterior draws:
$$
\Pr(\tilde y=1\mid \tilde x,y)\approx \frac{1}{S}\sum_{s=1}^S \sigma(\tilde x'\theta^{(s)}).
$$

See `code/bayes-logistic.ipynb` as an example to implement the above procedure.

## Variational Inference

For many Bayesian models (including logistic regression), exact posterior calculations are infeasible and MCMC may be computationally expensive in large datasets or high dimensions. **Variational inference (VI)** is an optimization-based alternative: it approximates the posterior $p(\theta\mid y)$ by a simpler distribution $q(\theta)$ chosen from a tractable family.

### Core idea: approximate $p(\theta\mid y)$ by $q(\theta)$

Choose a variational family $\mathcal{Q}$ and solve
$$
q^\ast \in \arg\min_{q\in\mathcal{Q}} \mathrm{KL}\big(q(\theta)\,\|\,p(\theta\mid y)\big),
$$
where $\mathrm{KL}(q\|p):=\int q(\theta)\log\frac{q(\theta)}{p(\theta)}\,d\theta$ is the Kullback-Leibler divergence.

This objective is equivalent to maximizing the **evidence lower bound (ELBO)**. Using Bayes' rule and the identity
$$
\log p(y)=\mathrm{ELBO}(q)+\mathrm{KL}\big(q(\theta)\,\|\,p(\theta\mid y)\big),
$$
we define
$$
\mathrm{ELBO}(q):=\mathbb{E}_q[\log p(y,\theta)]-\mathbb{E}_q[\log q(\theta)].
$$
Since the KL divergence is nonnegative, $\mathrm{ELBO}(q)\le \log p(y)$, hence the name.

### Common approximation families

The most common choice is **mean-field VI**, which assumes the components (or blocks) of $\theta$ are independent under $q$:
$$
q(\theta)=\prod_{j=1}^p q_j(\theta_j).
$$
This assumption makes optimization tractable but can understate posterior dependence.

### Computation: VI as an optimization problem

In practice, VI proceeds as follows:

1. Specify $\mathcal{Q}$ (e.g., mean-field Gaussian $q(\theta)=N(\mu,\Sigma)$ with diagonal $\Sigma$).
2. Write down $\mathrm{ELBO}(q)$ (often up to an additive constant).
3. Optimize the ELBO over variational parameters (e.g., $\mu,\Sigma$) using coordinate ascent (when available) or stochastic gradient methods.

In modern machine learning, VI is often implemented with stochastic gradients and minibatches, and it supports **amortized inference** (learning a map from data to variational parameters) in latent-variable models.

### What VI gives you (and what it may miss)

VI typically delivers fast approximate posterior means and predictive distributions. However, the direction of KL used in standard VI, $\mathrm{KL}(q\|p)$, tends to penalize putting mass where the true posterior has little mass, which can lead to **overconfident** (too narrow) approximations when $\mathcal{Q}$ is restrictive.

As a practical workflow, VI is often used for rapid inference and model comparison, and then validated against MCMC on smaller problems or with targeted diagnostics (predictive checks, sensitivity to $\mathcal{Q}$, and stability of posterior summaries).
