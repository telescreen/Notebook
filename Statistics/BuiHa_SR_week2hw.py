#%% Import packages
import numpy as np
import scipy.stats as stats
import pandas as pd
import matplotlib.pyplot as plt
import pymc as pm
import arviz as az
import xarray as xr


plt.style.use('ggplot')

#%% Read data from csv and do the regression.
howell = pd.read_csv('Data/Howell1.csv', sep=';')
adults = howell[howell.age >= 18]

#%% Regression weight ~ height.
height_bar = adults.height.mean()
with pm.Model() as m1:
    a = pm.Normal("a", 45, 10)
    b = pm.Lognormal("b", 0, 1)
    mu = a + b * (adults.height.values - height_bar)
    sigma = pm.Normal("sigma", 1)
    w = pm.Normal("weight", mu, sigma, observed=adults.weight.values)
    idata = pm.sample()

az.summary(idata)

#%% Plot result
pweight = idata.posterior['a'] + idata.posterior['b'] * xr.DataArray(adults.height - height_bar)
az.plot_lm(y='weight', idata=idata)

#%% Predict
# iheight is the height that we need to predict
# pweight is the expected weight
iheight = np.array([140, 160, 175])
pweight = idata.posterior['a'] + idata.posterior['b'] * (iheight - height_bar)
print(pweight.mean(1))