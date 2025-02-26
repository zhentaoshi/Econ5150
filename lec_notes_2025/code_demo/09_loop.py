# %%
import numpy as np
import time

mu = 2 

def CI(x):
    # x is a numpy array of random variables
    n = len(x)
    mu = np.mean(x)
    sig = np.std(x)
    upper = mu + 1.96 / np.sqrt(n) * sig
    lower = mu - 1.96 / np.sqrt(n) * sig
    return {"lower": lower, "upper": upper}


def capture(_):
    x = np.random.poisson(mu, sample_size)
    bounds = CI(x)  # You need to define the CI function in Python
    return (bounds['lower'] <= mu) & (mu <= bounds['upper'])


Rep = 1000000 # or whatever value you choose
sample_size = 2 # or whatever value you choose
mu = 10 # or whatever value you choose

np.random.seed(1) # set seed for reproducibility
out = [] # initialize out as empty list
pts0 = time.time() # check time

i = 0
while i < Rep:
    out.append(capture(i))
    i += 1

pts1 = time.time() - pts0 # check time elapsed
print("loop without pre-definition takes", pts1, "seconds")

out1 = [False] * Rep # initialize out as empty list
pts0 = time.time() # check time

for i in range(Rep):
    out1[i] = capture(i)

pts1 = time.time() - pts0 # check time elapsed
print("loop without pre-definition takes", pts1, "seconds")
# %%

# define an empty np array
pts2 = time.time() # check time

for i in range(Rep):
    if i == 0:
        out2 = capture(i)
    else:
        out2 = np.append(out2, capture(i))

pts2 = time.time() - pts2 # check time elapsed
print("loop without pre-definition takes", pts2, "seconds")
# %%
