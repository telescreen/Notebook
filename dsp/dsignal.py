#!/usr/bin/env python3

import numpy as np
from typing import Callable
from collections import namedtuple


Signal = namedtuple('Signal', ['time', 'value'])

def sigscale(signal: Signal, alpha: float) -> Signal:
    """ Return a new Signal, whose its value is scaled by alpha """
    return (signal.time, signal.value * alpha)


def sigshift(signal: Signal, k: int) -> Signal:
    """ Return a new Signal, whose its time is shifted by k units """
    return Signal(signal.time + k, signal.value)


def sample_sum(signal: Signal, n1: int, n2: int) -> float:
    """ Return sum of samples whose indexes are betwen n1 and n2 """
    return np.sum(signal.value[(n1 <= signal.time) & (signal.time <= n2)])


def sample_product(signal: Signal, n1: int, n2: int) -> float:
    """ Return product of samples whose indexes are betwen n1 and n2 """
    return np.product(signal.value[(n1 <= signal.time) & (signal.time <= n2)])


def energy(signal: Signal) -> float:
    """ Return energy of this signal """
    return np.sum(signal.value * signal.value)


def sigfold(signal: Signal) -> Signal:
    """ Return a new signal with y(n) = x(-n) """
    return Signal(-np.flipud(signal.time), np.flipud(signal.value))


def tile(signal: Signal, n: int) -> Signal:
    """ Return n period periodic signal from current signal
    Input: n = period
    """
    lbound = np.min(signal.time)
    hbound = len(signal.value) * (n / 2 - 1) - np.max(signal.time) - 1
    return Signal(np.arange(lbound, hbound), np.tile(signal.value, n))


def sigadd(x: Signal, y: Signal) -> Signal:
    lbound = min(np.min(x.time), np.min(y.time))
    hbound = max(np.max(x.time), np.max(y.time))
    n = np.arange(lbound, hbound + 1)
    y1 = np.zeros(hbound - lbound + 1)
    y2 = np.zeros(hbound - lbound + 1)
    y1[(lbound <= x.time) & (x.time <= hbound)] = x.value
    y2[(lbound <= y.time) & (y.time <= hbound)] = y.value
    return Signal(n, y1 + y2)


def sigmult(x: Signal, y: Signal) -> Signal:
    lbound = min(np.min(x.time), np.min(y.time))
    hbound = max(np.max(x.time), np.max(y.time))
    n = np.arange(lbound, hbound + 1)
    y1 = np.zeros(hbound - lbound + 1)
    y2 = np.zeros(hbound - lbound + 1)
    y1[(lbound <= x.time) & (x.time <= hbound)] = x.value
    y2[(lbound <= y.time) & (y.time <= hbound)] = y.value
    return Signal(n, y1 * y2)


def impseq(n0: int, n1: int, n2: int) -> Signal:
    """ Generate signal delta(n-n0). n1 <= n <= n2 """
    t = np.arange(n1, n2 + 1)
    x = np.zeros(n2 - n1 + 1)
    x[t == n0] = 1
    return Signal(t, x)


def stepseq(n0: int, n1: int, n2: int) -> Signal:
    """ Generate signal unit(n-n0). n1 <= n <= n2 """
    t = np.arange(n1, n2 + 1)
    x = np.zeros(n2 - n1 + 1)
    x[t >= n0] = 1
    return Signal(t, x)


def expseq(n1: int, n2: int, a: float) -> Signal:
    """ Generate a power signal in range n1 : n2 """
    t = np.arange(n1, n2 + 1)
    return Signal(t, np.power(a, t))


def randseq(n1: int, n2: int) -> Signal:
    from numpy.random import default_rng
    rng = default_rng()
    t = np.arange(n1, n2 + 1)
    return Signal(t, rng.standard_normal(n2-n1+1))


def genseq(n1: int, n2: int, f: Callable[[np.ndarray], np.ndarray]) -> Signal:
    """ Generate a signal in range n1 : n2 with signal value calculated by f """
    t = np.arange(n1, n2+1)
    return Signal(t, f(t))
