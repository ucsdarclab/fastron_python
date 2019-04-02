# fastronWrapper Test

import pytest
from pprint import pprint

import numpy as np 
import fastronWrapper

# toy data
data = np.array([[1.0,2.0,3.0],
                [4.0,5.0,6.0],
                [7.0,8.0,9.0],
                [10.0,11.0,12.0]],
                order='F')   # !!IMPORTANT store in colmun major, type matters
print("Numpy data:")
pprint(data)

# initialize fastron class
pyf = fastronWrapper.PyFastron(data)

#pyf.data = data

print(pyf.N)
print(pyf.d)
print(data.shape)

print("ArrayXd")
print(pyf.alpha)
print(pyf.F)
print(pyf.y)

print("sigma")
print(pyf.sigma)

def test_attribute_access():
    # model update parameters: gamma (kernel width), beta (conditional bias)
    assert pyf.g == 10
    assert pyf.beta == 1
    
    # max update iterations, max number of support points
    assert pyf.maxUpdates == 1000
    assert pyf.maxSupportPoints == 0

    # Gram matrix and dataset of configurations
    # TODO: Gram matrix
    assert pyf.data.all() == data.all()
    
    # number of datapoints and dimensionality
    assert pyf.N == data.shape[0]
    assert pyf.d == data.shape[1]

    # weights, hypothesis, and true labels
    assert pyf.alpha.all() == np.zeros([pyf.N, 1]).all()
    assert pyf.F.all() == np.zeros([pyf.N, 1]).all()
    assert pyf.y.all() == np.zeros([pyf.N, 1]).all()

    # active learning parameters: allowance (number of new samples), kNS (number of points near supports), sigma (Gaussian sampling std), exploitP (proportion of exploitation samples)
    assert pyf.allowance == 800
    assert pyf.kNS == 4
    #assert pyf.sigma == 0
    assert pyf.exploitP == 0.5
    

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
    # TODO: Gram matrix
    data[0][0] == 0.0
    assert pyf.data.all() == data.all()

    # number of datapoints and dimensionality
    # TODO

    # weights, hypothesis, and true labels
    # TODO


    # active learning parameters: allowance (number of new samples), kNS (number of points near supports), sigma (Gaussian sampling std), exploitP (proportion of exploitation samples)
    pyf.allowance = 1000
    pyf.kNS = 5
    pyf.exploitP = 0.8
    assert pyf.allowance == 1000
    assert pyf.kNS == 5
    #assert pyf.sigma == 0
    assert pyf.exploitP == 0.8

    