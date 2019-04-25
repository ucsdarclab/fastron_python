# Python Implementation of Fastron

A Cython interface to implement Fastron library in Python environment

Still working on this documentation file

## Use Fastron in Python
The Cython wrapper is already setup, hence Fastron can be directly imported.
Initialze Fastron class with training data (numpy 2d array)
```
import numpy as np
import fastronWrapper

...

fastron = fastronWrapper.PyFastron(data)
```

## Issues
When trying to setup the Cython wrapper, compilation error may occur on some Eigen functions. This is because the bridge between numpy and Eigen, Eigency, maintains its own version of Eigen library and it is outdated. To fix this issue, replace that library with the latest Eigen library.
