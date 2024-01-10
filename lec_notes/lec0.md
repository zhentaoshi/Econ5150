
# Introduction

(ZT writes the very first draft on 20240110. To be revised and proofread.)

Please dont' read.


This is the second course of the Ph.D. econometrics sequel. The theme is to use asymptotic theory to study the behavior of various statistics in econometrics.

## Statistical Learning

Machine learning and more genreal artificial intelligence are popular concepts in recent years. Econometrics, if we want, can also be part of the machine learning endevor.

The two broad categories of machine learning are supervised learning and unsupervised learning. In unsupervised learning, we only have the input data. The goal is to learn the structure of the data. In supervised learning, we have a set of data with both the input and output. The goal is to learn the relationship between the input and output.

Let me give some simple examples. Now you are a graduate student of CUHK. You must be interested in the anticipated salary after your graduation. The question "How much does an average university graduate earn?" is a question of unsupervised learning. An this is an empirical question, as no microeconomic theory or macroeconomic theory can give us an answer. We must a representitive sample of CUHK graduates infer the population average. Such uninteresting examples fill undergradute statistical textbooks, where we spend much time to learn how to estimate the population mean and quantify the uncertainty.

What we learned from undergraduate econometrics is slightly more interesting. The question "Do students with better academic performance in earns more future salary?" is a question of supervised learning,
as we have a targeted variable, the salary, and the explanatory variable, the academic performance, say measured by GPA. We can run an OLS regression to learn the association between the two variables.


## Economic Learning

The above two are statistical questions. Student with higher GPAs in university may be smarter or work harder, which makes them more efficient workers in the future.
We, as economists, consider deeper causal questions: "How much does your GPA boost your salary?" This is about one person in two different hypothetical worlds.
Once you are enrolled into university, you can choose to work hard and keep a high GPA, or you can choose to play hard and that usually leads to a unsatisfactory GPA.
Collecting the salary and GPA data only is insufficient to answer this question. We need to have a framework and a design to answer this question. This is the realm of econometrics.

The above causal question is a very straightforward one, as the cause and the consequence are clearly defined. However, in many important context of great economics interest and importance, the setting is not as clear-cut. For example, we are interested in the effect of a country's level of government debt and the chance of financial crisis. The problem is that the government debt is endogenous, as the government may borrow more when the economy is in a downturn.


## Econometrics Theory

Econometrics theory helps answer econometrics questions. These econometrics questions are based on the economics modeling. Given observed data, in some cases the researcher might only be able to answer a statistical question. If she is lucky, in some cases it is also possible to answer an economic question involving causality. If the researcher has enough resources, she may go out and design an experiment to question the causal question more convincingly. In some cases, the causal question can only be based on the model but not an experiment in the real world. For example, no government want to be the subject of an experiment in order to learn the effect of a hyperinflation on the economy.

A broadly defined econometric theory should include all aspects from thinking about the economic question, design the experiment, conducting the experiment, collecting the data, analyzing the data, and drawing the conclusion. On the other hand, given the time limit, this course will cover a narrowly defined econometric theory. That is, we suppose that the model is given and the data are ready. We focus on how to use the data to draw inference about the parameters in the model.

Because the observations are random, we count on probabilistic and statistical theory to shed light on the properties of the estimators. The asymptotic theory is the most important tool in this course. The asymptotic theory is a branch of probability theory. It studies the behavior of a sequence of random variables when the sample size goes to infinity. The asymptotic theory is the foundation of modern econometrics.

The first three lectures will give an overall picture of the asymptotic theory we use. They are followed by several applications to statistical estimators in the broad class of extremum estimators. The extremum estimators include OLS, GMM, MLE and quantile regressions as special cases. 

For simplicity, we will focus on the case of independent data. In the real world, for example in macroeconomic and financial applicatiosn the data are often collected over time and they are naturally dependent. The second part of the course will be about the asymptotic theory of dependent data and applications to popular time series models.

