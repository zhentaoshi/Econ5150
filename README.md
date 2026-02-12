

# Econ5150: Applied Econometrics

[![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

* Time: Thursday 9:30am – 12:15pm
* Venue: ELB 304

**2026 Spring**

This repository hosts lecture notes and code. They will be updated as the course progresses.


### Textbooks

* Chernozhukov, Hansen, Kallus, Spindler, and Syrgkanis (2025): Applied Causal Inference Powered by ML and AI [[link](https://CausalML-book.org)]
<!-- * Hansen (2021): Probability and Statistics for Economists -->
* Hansen (2021): Econometrics

**Recommended reading**
* Goodfellow, Bengio, and Courville (2016): Deep learning, MIT Press [[link](https://www.deeplearningbook.org/)].
* Hastie, Tibshirani, and Friedman (2009): The Elements of Statistical Learning [[link](https://hastie.su.domains/ElemStatLearn/)]


### Introduction

As a sequel to ECON5120, this course develops a modern toolkit for applied econometric work: credible causal questions, transparent identification assumptions, and methods that remain reliable in high-dimensional data and computationally intensive settings.
In the era of AI, econometrics must evolve—not by replacing economic reasoning, but by combining it with statistically principled estimation, careful uncertainty quantification, and reproducible workflows.

By the end of the course, you should be able to:


* Implement estimation and inference for linear and nonlinear models, including likelihood-based methods and moment-based methods.
* Use asymptotic approximations as guidance, and recognize settings where they can fail (extreme estimators, nonstandard problems).
* Apply regularization and ML methods as components of econometric procedures (prediction + causal inference), with attention to overfitting and valid inference.
* Build computational solutions (optimization, simulation, bootstrap) and present results in a replicable code-and-data pipeline.


### Topics


* Linear Models
  * Causal inference
  * Review of linear regressions
  * Large sample theory and OLS
  * Shrinkage methods

* Nonlinear Models
  * Maximum likelihood
  * Limited dependent variables
  * Extreme estimators
  * Generalized method of moments
  * Quantile regressions
  * Numerical optimization
  * Large sample theory and nonparametric methods
  * Machine learning and causal inference

* Special topics
  * Time series
  * Factor models
  * Panel data



### Prerequisites

* ECON5120

### Assessment

* Midterm: 50%
* Final: 50%



### Reading

* Week 1: potential outcome framework, average treatment effect, conditional ATE, propensity score, conditional independence assumptions, continuous treatment
  * CHKSS Ch.2, Ch.5; Hansen Ch.2.1-8, 2.30

* Week 2: causal inference based on regressions, conditional mean, linear projection, FWL theorem, omitted variable bias, ridgeless regression
  * CHKSS Ch.0, Ch.1.1, Ch.1.2 (up to p.20), Ch.1.3 (up to p.25); Hansen Ch.2.15-25; 3.1-18
 
* Week 3: finite sample mean and variance of OLS, in-sample overfitting, out-of-sample prediction, asymptopia, modes of convergence
  * CHKSS the rest of Ch.1; Hansen Ch.4.1-12, 6.1-2

* Week 4: LLN, CLT, asymptotic properties of OLS estimator. Ridge, bias and variance tradeoff.
  * CHKSS Ch.3.3; Hansen Ch 29.1-7.

* Week 5: lasso, KKT condition, adaptive lasso, restricted eigenvalue condition, consistency, Neyman orthogonality
  * CHKSS Ch.3, Ch.4.1-4.3

* Week 6: Neyman orthogonality, desparsified lasso, Shannon entropy, Kullback-Leibler distance, differential entropy, likelihood
  * Hansen (probability book) Ch.10.1-7

## License

This work is licensed under
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg
