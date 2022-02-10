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

plt.style.use('ggplot')
plt.rcParams['figure.figsize'] = (8.0, 6.0)
plt.rcParams['font.size'] = 14

#%%
N = 1000
Z = np.random.binomial(1, 0.5, N)
X = np.random.binomial(1, (1-Z)*0.1 + Z*0.9, N)
Y = np.random.binomial(1, (1-Z)*0.1 + Z*0.9, N)
pd.crosstab(X, Y, rownames=['X'], colnames=['Y'])
print(np.corrcoef(X, Y))

#%%
print(pd.crosstab(X[Z==0], Y[Z==0], rownames=['X'], colnames=['Y']))
print(np.corrcoef(X[Z==0], Y[Z==0]))
print(pd.crosstab(X[Z==1], Y[Z==1], rownames=['X'], colnames=['Y']))
print(np.corrcoef(X[Z==1], Y[Z==1]))

#%%
N = 300
Z = np.random.binomial(1, 0.5, N)
X = np.random.normal(2*Z-1, 1, N)
Y = np.random.normal(2*Z-1, 1, N)

plt.scatter(X, Y, c=Z, cmap='coolwarm')
plt.xlabel("X")
plt.ylabel("Y")

#%%
WDdat = pd.read_csv("Data/WaffleDivorce.csv", sep=';')
WDdat