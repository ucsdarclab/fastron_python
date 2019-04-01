# fastronWrapper Test

import pytest
from pprint import pprint

import numpy as np 
import fastronWrapper

data = np.array([[1.0,2.0,3.0],
                [4.0,5.0,6.0],
                [7.0,8.0,9.0],
                [10.0,11.0,12.0]],
                order='F')   # !!IMPORTANT store in colmun major, type matters
pprint(data)

pyf = fastronWrapper.PyFastron(data)

print(pyf.G)

pyf.data = data

print(pyf.N)
print(pyf.d)
print(data.shape)

def test_attribute_access():
    # model update parameters: gamma (kernel width), beta (conditional bias)
    assert pyf.g == 10
    assert pyf.beta == 1
    
    # max update iterations, max number of support points
    assert pyf.maxUpdates == 1000
    assert pyf.maxSupportPoints == 0

    # Gram matrix and dataset of configurations
    # TODO

    # number of datapoints and dimensionality
    assert pyf.N == data.shape[0]
    assert pyf.d == data.shape[1]


def test_attribute_modification():
    # model update parameters: gamma (kernel width), beta (conditional bias)
    pyf.g = 20
    pyf.beta = 2
    assert pyf.g == 20 
    assert pyf.beta == 2

    # max update iterations, max number of support points
    pyf.maxUpdates = 2000
    pyf.maxSupportPoints = 100
    assert pyf.maxUpdates == 2000
    assert pyf.maxSupportPoints == 100

    # Gram matrix and dataset of configurations
    # TODO

    # number of datapoints and dimensionality
    # TODO


    