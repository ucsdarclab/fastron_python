# fastronWrapper Test Update Model

import pytest
from pprint import pprint

import numpy as np 
import fastronWrapper

# toy data
data = np.array([[1.0,1.0,1.0,1.0],
                [4.0,4.0,4.0,4.0],
                [20.0,20.0,20.0,20.0],
                [20.0,20.0,20.0,20.0]],
                order='F')   # !!IMPORTANT store in colmun major, type matters
print("Numpy data:")
pprint(data)

# initialize fastron class
pyf = fastronWrapper.PyFastron(data)

# update model
pyf.y = np.array([[1.],[1.],[-1.],[-1.]])
pyf.maxSupportPoints = 100
pyf.updateModel()

# train error
print("y:\n", pyf.y)
print("F:\n", pyf.F)

# proxy check
query_points = np.array([[1.0,1.0,1.0,1.0],
                [4.0,4.0,4.0,4.0],
                [20.0,20.0,20.0,20.0],
                [20.0,20.0,20.0,20.0]],
                order='F')
print(pyf.eval(query_points))