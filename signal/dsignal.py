#!/usr/bin/env python3

import numpy as np

class Signal:
    def __init__(self, time: np.ndarray, value: np.ndarray):
        """ Time is the time sequence. x is the values """
        if not isinstance(time, np.ndarray) or not isinstance(value, np.ndarray):
            raise ValueError("Time and Signal needs to be numpy array.")
        self._time = time
        self._value = value

    @property
    def time(self):
        return self._time

    @property
    def value(self):
        return self._value

    def scale(self, alpha: float):
        """ Return a new Signal, whose its value is scaled by alpha """
        return Signal(self._time, self._value * alpha)

    def shift(self, k: int):
        """ Return a new Signal, whose its time is shifted by k units """
        return Signal(self._time + k, self._value)

    def sample_sum(self, n1: int, n2: int) -> float:
        """ Return sum of samples whose indexes are betwen n1 and n2 """
        return np.sum(self._value[(n1 <= self._time) & (self._time <= n2)])

    def sample_product(self, n1: int, n2: int) -> float:
        """ Return product of samples whose indexes are betwen n1 and n2 """
        return np.product(self._value[(n1 <= self._time) & (self._time <= n2)])

    def energy(self) -> float:
        """ Return energy of this signal """
        return np.sum(self._value * self._value)

    def fold(self):
        """ Return a new signal with y(n) = x(-n) """
        return Signal(-np.fliplr(self._time), np.fliplr(self._value))

    def __add__(self, oSignal):
        lbound = min(np.min(self._time), np.min(oSignal.time))
        hbound = max(np.max(self._time), np.max(oSignal.time))
        n = np.arange(lbound, hbound + 1)
        y1 = np.zeros(hbound - lbound + 1)
        y2 = np.zeros(hbound - lbound + 1)
        y1[(lbound <= self._time) & (self._time <= hbound)] = self._value
        y2[(lbound <= oSignal.time) & (oSignal.time <= hbound)] = oSignal.value
        return Signal(n, y1 + y2)

    def __neg__(self):
        return Signal(self._time, -self._value)

    def __sub__(self, oSignal):
        return self.__add__(-oSignal)

    def __mul__(self, oSignal):
        if isinstance(oSignal, int):
            return Signal(self._time, oSignal * self._value)

        elif isinstance(oSignal, np.ndarray):
            if self._value.shape != oSignal.shape:
                raise ValueError("2 arrays should have the same shape")
            return Signal(self._time, oSignal * self._value)

        elif isinstance(oSignal, Signal):
            lbound = min(np.min(self._time), np.min(oSignal.time))
            hbound = max(np.max(self._time), np.max(oSignal.time))
            n = np.arange(lbound, hbound + 1)
            y1 = np.zeros(hbound - lbound + 1)
            y2 = np.zeros(hbound - lbound + 1)
            y1[(lbound <= self._time) & (self._time <= hbound)] = self._value
            y2[(lbound <= oSignal.time) & (oSignal.time <= hbound)] = oSignal.value
            return Signal(n, y1 * y2)

    def __rmul__(self, num):
        return self.__mul__(num)

    def __len__(self):
        return self._value.shape[0]

    def __repr__(self):
        return "t: {}\nx: {}".format(self._time, self._value)


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
    t = np.arange(n1, n2 + 1)
    return Signal(t, np.power(a, t))


def randseq(n1: int, n2: int) -> Signal:
    from numpy.random import default_rng
    rng = default_rng()
    t = np.arange(n1, n2 + 1)
    return Signal(t, rng.standard_normal())


if __name__ == "__main__":
    x = stepseq(0, -2, 2)
    a = np.array([1,2,3,4,5])
    print(a * x)
