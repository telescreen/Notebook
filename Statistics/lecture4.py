## Calculation scripts for lecture 4
#%% Import
import warnings

import numpy as np
import scipy.stats as stats
import pandas as pd
import matplotlib.pyplot as plt
import pymc as pm
import arviz as az
import seaborn as sns

warnings.simplefilter("ignore", FutureWarning)

plt.style.use('seaborn-darkgrid')
plt.rcParams['figure.figsize'] = (8.0, 6.0)
plt.rcParams['font.size'] = 14

#%% Load data
howell = pd.read_csv("Data/Howell1.csv", sep=';')
data = howell[howell.age >= 18]

#%%
plt.scatter(data.height[data.male == 1], data.weight[data.male == 1], label='men')
plt.scatter(data.height[data.male == 0], data.weight[data.male == 0], label='women')
plt.legend(loc='lower right')
plt.xlabel("height (cm)")
plt.ylabel("weight (kg)")


#%% Kernel density estimate of men / womens
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 6))
sns.kdeplot(data.height[data.male == 1], bw_adjust=0.5, ax=ax1, label='men')
sns.kdeplot(data.height[data.male == 0], bw_adjust=0.5, ax=ax1, label='women')
ax1.legend()
sns.kdeplot(data.weight[data.male == 1], bw_adjust=0.5, ax=ax2, label='men')
sns.kdeplot(data.weight[data.male == 0], bw_adjust=0.5, ax=ax2, label='women')
ax2.legend()

#%% Model: Weight based on Sex
with pm.Model() as m41:
    mu = pm.Normal("mu", 60, 10, shape=2)
    sigma = pm.Uniform("sigma", 0, 10)
    W = pm.Normal("Weight", mu[data.male.values], sigma, observed=data.weight)
    diff = pm.Deterministic('diff', mu[1] - mu[0])
    idata41 = pm.sample()
    post41 = pm.sample_posterior_predictive(idata41)

az.summary(idata41)

#%% Kernel Density of Posterior Mean Weight
mu = idata41.posterior['mu']
sns.kdeplot(mu[0, :, 0], label='women', linewidth=4)
sns.kdeplot(mu[0, :, 1], label='men', linewidth=4)
plt.xlabel('Posterior mean weight(kg)')
plt.legend()

#%% Kernel Density of Posterior weight
diff = idata41.posterior['diff'].values.reshape(-1)
sns.kdeplot(diff, bw_adjust=0.5, linewidth=4, fill=True)
plt.xlabel('posterior mean weight contrast (kg)')

#%% Posterior Predicted Weight
mu_women = idata41.posterior['mu'][:,:,0].values.reshape(-1)
mu_men = idata41.posterior['mu'][:,:,1].values.reshape(-1)
sigma = idata41.posterior['sigma'].values.reshape(-1)
W0 = np.random.normal(mu_women.mean(), sigma.mean(), 2000)
W1 = np.random.normal(mu_men.mean(), sigma.mean(), 2000)
W_contrast = W1 - W0
#%%
kde = stats.gaussian_kde(W_contrast)
kde.set_bandwidth(bw_method=kde.factor/2)
x_plot = np.linspace(W_contrast.min(), W_contrast.max(), 100)
plt.plot(x_plot, kde(x_plot), linewidth=4)
plt.fill_between(x_plot, kde(x_plot), alpha=0.6)
plt.fill_between(x_plot, kde(x_plot), where=x_plot < 0, color='r', alpha=0.6)
plt.text(-10, 0.03, "{:.0%}".format(np.sum(W_contrast < 0)/2000), fontsize=24, weight='bold', color='r')
plt.text(18, 0.03, "{:.0%}".format(np.sum(W_contrast > 0)/2000), fontsize=24, weight='bold')

#%%
plt.scatter(data.height[data.male == 1], data.weight[data.male == 1], label='men')
plt.scatter(data.height[data.male == 0], data.weight[data.male == 0], label='women')
plt.legend(loc='lower right')
plt.xlabel("height (cm)")
plt.ylabel("weight (kg)")
