# Python Implementation of Fastron

A Cython interface to implement Fastron library in Python environment

Still working on this documentation file

## Use Fastron in Python
The Cython wrapper is already setup. Fastron can be directly imported.
Initialze Fastron class with training data (numpy 2d array)
```
import numpy as np
import fastronWrapper

...

fastron = fastronWrapper.PyFastron(data)
```
