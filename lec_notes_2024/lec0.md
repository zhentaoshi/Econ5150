
# Introduction


This is the second course of the Ph.D. econometrics sequel. The theme is to use asymptotic theory to study the behavior of various statistics in econometrics.

## The learning business

### Statistical Learning

Machine learning and more generally artificial intelligence are popular concepts in recent years. Econometrics, if we want, can also be part of the machine learning endeavor.

The two broad categories of machine learning are *supervised learning* and *unsupervised learning*. The former only involves input data, and latter requires both the input and output. 

Let me give some simple examples. You are a graduate student. You must be interested in the anticipated salary after your graduation. "How much does an average university graduate earn?" is a question of unsupervised learning. This is an empirical question, as no microeconomic theory or macroeconomic theory can give us an answer. We must a representative sample of graduates to infer the population average. Such uninteresting examples fill undergraduate statistical textbooks, where we spend much time to learn how to estimate the population mean and quantify the uncertainty.

What in undergraduate econometrics are slightly more interesting. "Do students with better academic performance earn more future salary?" is a question of supervised learning,
as we have a targeted variable, the salary, and the explanatory variable, the academic performance, say measured by GPA. We can run an OLS regression to learn the association between the two variables.

### Economic Learning

The above supervised learning example answers a statistical question of association. Students with higher GPAs in university may be smarter or work harder, which make them more efficient workers in the future.
We, as economists, consider deeper causal questions. "How much does your academic performance boost your salary?" is about the same person in two different hypothetical worlds.
Once you are enrolled into university, you can choose to work hard and keep a high GPA, or you play hard and that usually leads to a unsatisfactory GPA.
Collecting the salary and GPA data only is insufficient to answer the causal question. We need to have a framework and a design in mind. This is in the realm of econometrics.

The example is a straightforward one, as the cause and the effect are clearly defined. In many important context of great economics interest and importance, the setting is not as clear-cut however. For example, we are interested in the effect of a country's level of government debt and the chance of financial crisis. The problem is that the government debt is endogenous, as the government may borrow more when the economy is in a downturn.


### Econometrics Theory

Econometrics theory helps answer econometrics questions. These econometrics questions are based on the economics modeling. Given observed data, in some cases the researcher might only be able to answer a statistical question. If she is lucky, it is also possible to shed light on an economic question involving causality. If the researcher has enough resources, she may go out to the field and design an experiment to explore the causal question more convincingly. In some instances, the causal question can only be based on the model but not on an experiment in the real world. No government wants to be the subject of an experiment in order to learn the effect of a hyperinflation on the economy.

Econometric theory, broadly defined,  should include all aspects from thinking about the economic question, designing the experiment, conducting the experiment, collecting the data, analyzing the data, and drawing the conclusion. On the other hand, given the time limit, this course will cover narrowly defined econometric theory. That is, we suppose that the model is given and the data are ready. We focus on how to use the data to draw inference about the parameters of interest in the model.

Because the observations are random, we count on probabilistic and statistical theory to provide properties of the estimators. Asymptotic theory, a branch of probability theory, is the most important tool in this course. It studies the behavior of a sequence of random variables when the sample size goes to infinity. It is the foundation of modern econometrics.

The first three lectures will give an overall picture of the asymptotic theory we use. They are followed by applications to econometric estimators in the class of extremum estimators. The extremum estimators subsume OLS, GMM, MLE and quantile regressions as special cases.

In the real world, for example in macroeconomic and financial applications the data are often collected over time and they are naturally dependent. The second part of the course will be about the dependent data and popular time series models.



## Lecture Notes

These lecture notes are developed out of the textbooks. The pair of the textbooks have around 1400 pages. It is impossible to cover such a wide range of topics in one year. Therefore, in the chapters I intend to cover, I only select the essence to write down. Therefore, the lecture notes cover the most important topics.

Occasionally, I also use the lecture notes to express my views. These notes, inevitably, reflects a personal take of the body of the econometric literature.


## History

OLS: 1800 Gauss

Logistic: 1840

IV: 1920

MLE: 1921, 1925

GMM: 1982

Unit root: 1986

Lasso: 1996

High dimensional Lasso: 2009

----
Econometric Society: 1923

China: 1985

----

Econometrics at Work

Program evaluation: Duflo et al

Household responsibility system: Justin Lin

Twins: JS Zhang

DID: Card and Kruger

Angrist

Panel data, control heterogeneity

Financial econometrics

Havvolmo, Koopmans

----

The use and abuse

