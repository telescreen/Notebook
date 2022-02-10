#%% Import necessary packages
# Necessary package: numpy, scipy, arviz
import numpy as np
import scipy.stats as stats
import arviz as az

#%% Helpers
def binom_grid_approx(W: int, L: int, prior: np.ndarray, grid_size: int = 1000) -> np.ndarray:
    """
    Parameters:
    ---------------
    W: int
        number of Water
    L: int
        number of Land
    prior: np.ndarray
        the prior distribution over grid

    Returns:
    ---------------
    np.ndarray
        posterior distribution approximation using grid
    """
    p_grid = np.linspace(0, 1, grid_size)
    prob_data = stats.binom.pmf(W, W + L, p_grid)
    posterior = prob_data * prior
    return posterior / np.sum(posterior)


def sampling(posterior: np.ndarray, N: int = 10000) -> np.ndarray:
    """
    Parameters:
    ---------------
    posterior: np.ndarray
        the posterior distribution over grid
    N: int
        the number of samples
    Returns:
    ---------------
    np.ndarray
        The sampled value with posterior distribution.
    """
    p_grid = np.linspace(0, 1, posterior.size)
    return np.random.choice(p_grid, N, replace=True, p=posterior)

GRID_SIZE = 1000
SAMPLE_SIZE = 10000
## Example
# prior = np.repeat(1, GRID_SIZE)
# posterior = binom_grid_approx(3, 0, prior, GRID_SIZE)
# samples = sampling(posterior, SAMPLE_SIZE)
# # The probability that the proportion of Water/Land < 0.5
# print(np.sum(samples < 0.5) / 10000)
# # The probability that the proportion of Water/Land > 0.5 and < 0.75
# print(np.sum((samples > 0.5) & (samples < 0.75)) / SAMPLE_SIZE)
# # Left quantile
# print(np.quantile(samples, 0.8))
# # Middle quantile
# print(np.quantile(samples, [0.25, 0.75]))
# print(az.hdi(samples, hdi_prob=0.5))
#%%
# Week 1 - HW1: Suppose the globe tossing data had turned out to be 4 water 
# and 11 land. Construct the posterior distribution, using grid approximation, 
# using the same flat prior
prior1 = np.repeat(1, GRID_SIZE)
posterior1 = binom_grid_approx(4, 11, prior1, GRID_SIZE)
samples1 = sampling(posterior1, SAMPLE_SIZE)

#%%
# Week 1 - HW2: Suppose the data are 4 water and 2 land. Compute the posterior 
# again, this time use a prior that is zero below p = 0.5 and a constant 
# above p = 0.5
prior2 = np.repeat([0, 1], GRID_SIZE//2)
posterior2 = binom_grid_approx(4, 2, prior2, GRID_SIZE)
samples2 = sampling(posterior2, SAMPLE_SIZE)

#%%
# Week 1 - HW3: For the posterior from 2, compute 89% percentile and HPDI intervals. Compare the
# width of these intervals. Which is wider? Why? If you had only the information in the interval
# what might you misunderstand about the shape of the posterior distribution

print("89% Percentile: ", np.quantile(samples2, [0.055, 0.945]))
print("89% HPDI", az.hdi(samples2, hdi_prob=0.5))

# import matplotlib.pyplot as plt
# plt.style.use('ggplot')
# plt.plot(posterior2)

# The 89% Percentile is wider than the 89% HPDI. The way we choose the prior, which empty out 
# the first half [0-0.5] of the grid cause the posterior distribution to zero out in this range.
# Therefore, the range needs to be wider to cover 89% values of the parameter (proportion of water)

#%%
# Week 1 - HW4 (Optional)
# Generate dataset where the proportion of water is 0.7, and 20% of Water samples are accidentally
# recorded instead as "Land".
def generate_bias_sample(p: float, p_bias: float, N: int) -> np.ndarray:
    """
    Parameters
    ------------------
    p: float
        proportion of Water
    p_bias
        proportion of Water that accidentally recorded as "Land".
    N: int
        number of samples

    Returns
    ------------------
    np.ndarray
        The simulated bias data
    """
    samples = np.random.binomial(1, p, N)
    number_of_waters = np.sum(samples)
    bias = np.sum(np.random.binomial(1, p_bias, number_of_waters))
    idx = np.where(samples == 1)[0]
    samples[idx[:bias]] = 0
    return samples
    
# The simulation tends to produce samples with proportion of Water of 0.56
samples4 = generate_bias_sample(0.7, 0.2, 1000)
print("Proportion of (biased) Water: ", np.sum(samples4)/1000)

prior4 = np.repeat(1, 20)
samples4 = generate_bias_sample(0.7, 0.2, 20)