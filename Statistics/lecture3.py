#%%
import warnings
import numpy as np
import scipy.stats as stats
import pymc as pm
import pandas as pd
import matplotlib.pyplot as plt
import arviz as az
import seaborn as sns

warnings.simplefilter("ignore", FutureWarning)

plt.style.use('ggplot')

#%%
# We have no prior knowledge about the proportion of Land and Water in Mars, so we assign 
# a Uniform probability for all proportion. We model the data with a binomial distribution 
# and compute the probability of observing the data with the proportion of Land/Water.
# We multiply our prior distribution with the probability of observing the data to form a 
# posterior distribution, which is the probability of observing Water in Mars, with the presense 
# of data.
# 
# Bayesian Data Analysis
# For each possible explanation of the data, Count all the ways data can happen, and
# Explanations with more ways to produce the data are more plausible.

p_grid = np.linspace(0, 1, 1000)
prob_p = np.repeat(1, 1000)
prob_data = stats.binom.pmf(6, 9, p=p_grid)
posterior = prob_data * prob_p
posterior = posterior / np.sum(posterior)

#%% 
# Plot the posterior distribution. This is the probability of observing Water 
# in the presense of data.
plt.plot(posterior)

#%%
samples = np.random.choice(p_grid, 10000, replace=True, p=posterior)

#%%
fig, ax = plt.subplots(1, 2, figsize=(12,5))
ax[0].plot(samples, 'o', alpha=0.6)
ax[0].set_xlabel('Sample Number')
ax[0].set_ylabel('Proportion water')
sns.kdeplot(samples, ax=ax[1])
ax[1].set_xlabel('Proportion water')
ax[1].set_ylabel('Density')


## Lecture 3
#%%
# Generate a simple dataset for linear regression
alpha = 0
beta = 0.5
sigma = 5
N = 100
H = np.random.uniform(130, 170, size=N)
mu = alpha + beta*H
W = np.random.normal(mu, sigma, size=N)
plt.plot(H, W, 'o')
plt.xlabel("Height")
plt.ylabel("Weight")

#%%
## Use pm(v4) to fit the linear model
with pm.Model() as m:
    a = pm.Normal("alpha", 0, 1)
    b = pm.Normal("beta", 0, 1)
    sigma = pm.Exponential("sigma", 1)
    mu = a + b*H
    w = pm.Normal("weight", mu, sigma, observed=W)
    trace = pm.sample()

#%%
az.summary(trace)
az.hdi(trace, var_names=["alpha", "beta"])

#%%
az.plot_forest(trace)