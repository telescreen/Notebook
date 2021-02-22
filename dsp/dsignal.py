#!/usr/bin/env python3

import numpy as np
from typing import Callable


def sigscale(x, alpha: float):
    """ Return a new Signal, whose its value is scaled by alpha """
    return x * alpha


def sigshift(t, x, k: int):
    """ Return a new Signal, whose its time is shifted by k units """
    return (t+k, x)


def sample_sum(t, x, n1: int, n2: int) -> float:
    """ Return sum of samples whose indexes are betwen n1 and n2 """
    return np.sum(x[(n1 <= t) & (t <= n2)])


def sample_product(t, x, n1: int, n2: int) -> float:
    """ Return product of samples whose indexes are betwen n1 and n2 """
    return np.product(x[(n1 <= t) & (t <= n2)])


def energy(x) -> float:
    """ Return energy of this signal """
    return np.sum(x**2)


def sigfold(t, x):
    """ Return a new signal with y(n) = x(-n) """
    return -np.flipud(t), np.flipud(x)


def sigtile(t, x, n: int):
    """ Return n period periodic signal from current signal
    Input: n = period
    """
    lbound = np.min(t)
    hbound = len(t) * (n / 2 - 1) - np.max(t) - 1
    return np.arange(lbound, hbound), np.tile(x, n)


def sigadd(tx, x, ty, y):
    lbound = min(np.min(tx), np.min(ty))
    hbound = max(np.max(tx), np.max(ty))
    n = np.arange(lbound, hbound+1)
    y1 = np.zeros(hbound - lbound + 1)
    y2 = np.zeros(hbound - lbound + 1)
    y1[(n >= np.min(tx)) & (n <= np.max(tx))] = x
    y2[(n >= np.min(ty)) & (n <= np.max(ty))] = y
    return n, y1 + y2


def sigmult(tx, x, ty, y):
    lbound = min(np.min(tx), np.min(ty))
    hbound = max(np.max(tx), np.max(ty))
    n = np.arange(lbound, hbound+1)
    y1 = np.zeros(hbound - lbound + 1)
    y2 = np.zeros(hbound - lbound + 1)
    y1[(n >= np.min(tx)) & (n <= np.max(tx))] = x
    y2[(n >= np.min(ty)) & (n <= np.max(ty))] = y
    return (n, y1 * y2)


def impseq(n0: int, n1: int, n2: int):
    """ Generate signal delta(n-n0). n1 <= n <= n2 """
    t = np.arange(n1, n2 + 1)
    x = np.zeros(n2 - n1 + 1)
    x[t == n0] = 1
    return x


def stepseq(n0: int, n1: int, n2: int):
    """ Generate signal unit(n-n0). n1 <= n <= n2 """
    t = np.arange(n1, n2 + 1)
    x = np.zeros(n2 - n1 + 1)
    x[t >= n0] = 1
    return x


def expseq(n1: int, n2: int, a: float):
    """ Generate a power signal in range n1 : n2 """
    t = np.arange(n1, n2 + 1)
    return np.power(a, t)


def randseq(n1: int, n2: int):
    from numpy.random import default_rng
    rng = default_rng()
    return rng.standard_normal(n2-n1+1)


def genseq(n1: int, n2: int, f: Callable[[np.ndarray], np.ndarray]):
    """ Generate a signal in range n1 : n2 with signal value calculated by f """
    return f(np.arange(n1, n2+1))


def conv_m(tx, x, ty, y):
    """ Modified convolution routine for signal processing 
    [tz, z] = conv_m(tx, x, ty, y)
    [tz, z] convolution result
    """
    tzb = tx[0] + ty[0]
    tze = tx[-1] + ty[-1]
    return np.arange(tzb, tze + 1), np.convolve(x, y)
    