# %%
import numpy as np
import matplotlib.pyplot as plt

# np.random.seed(2020-10-7)

mu0 = 2
gamma0 = 1

# population likelihood function
def L(mu):
  ell = -0.5 * np.log(2*np.pi*gamma0) - 0.5 *(1 + (mu - mu0)**2 / gamma0 ) 
  return ell

# sample likelihood function 
def Ln(mu):
  elln = -0.5 * np.log(2*np.pi*gamma0) - 0.5 * np.mean( (z - mu)**2 )/gamma0  
  return elln

mu_base = mu0 + np.linspace(-3, 3, 101)

# %% draw population log-likelihood graph

# draw sample log-likelihood graph
n = 10
lnz = np.zeros((len(mu_base), 3))
for rr in range(3):
  z = np.random.normal(mu0, np.sqrt(gamma0), size=n)
  lnz[:, rr] = np.array([Ln(mu) for mu in mu_base])

plt.plot(mu_base, L(mu_base), label='Population Likelihood')
plt.plot(mu_base, lnz[:, 0], label='Sample Likelihood 1', linestyle='--')
plt.plot(mu_base, lnz[:, 1], label='Sample Likelihood 2', linestyle='--')
plt.plot(mu_base, lnz[:, 2], label='Sample Likelihood 3', linestyle='--')
plt.axvline(x=mu0, linestyle=':', color='gray')
plt.xlabel('mu')
plt.ylabel('log-likelihood')
plt.ylim(-6, -1)
plt.legend()
plt.show()

# %%
