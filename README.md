# Python Implementation of Fastron

A Cython interface to implement Fastron library in Python environment

Still working on this documentation file

## Use Fastron in Python
The Cython wrapper is already setup, hence Fastron can be directly imported.
Initialze Fastron class with training data (numpy 2d array)

```python
import numpy as np
import fastronWrapper

...

fastron = fastronWrapper.PyFastron(data)
```

## Compile the Code

Before compiling the Fastron Cython code, make sure you have Eigen and Eigency installed.
```bash
pip install eigen
pip install eigency
```
If using Windows, you may need to install/update MS Visual C++ 14.0.
 
**NOTE: before compile, please read the issues section below**

To compile, run command:

```bash
python setup.py build_ext --inplace
```

## Issues
When trying to setup the Cython wrapper, compilation error may occur on some Eigen functions. This is because the bridge between numpy and Eigen, Eigency, maintains its own version of Eigen library and it is outdated. To fix this issue, replace that library with the latest Eigen library.

```bash
cd /tmp
curl -o eigen-3.3.7.tar.bz https://bitbucket.org/eigen/eigen/get/3.3.7.tar.bz2
tar -xvf eigen-3.3.7

# Need to rename it to eigen_3.2.8;
mv <untarred_directory> <conda_env>/lib/python3.7/site-packages/eigency/eigen_3.2.8
```

On Windows, replace Eigency's version of Eigen 3.2.8 (in site-packages) with Eigen 3.3.7.

## Usage
Import the fastronWrapper.pyx file to allow instantiation of PyFastron objects.
```bash
import pyximport
pyximport.install()

import numpy as np
from fastronWrapper.fastronWrapper import PyFastron
```

The PyFastron constructor only has a dataset of configurations (as a Numpy matrix) as an argument. Data labels (as a Numpy array) and kernel and model parameters can be set after construction.

The updateModel() method learns the weights for the model, and eval() predicts the collision status values with the trained model

### Example
```bash
# Initialize PyFastron
fastron = PyFastron(data) # where data.shape = (N, d)

fastron.y = y # where y.shape = (N,)

fastron.g = 10
fastron.maxUpdates = 10000
fastron.maxSupportPoints = 1500
fastron.beta = 100

# Train model
fastron.updateModel()

# Predict values for a test set
pred = fastron.eval(data_test) # where data_test.shape = (N_test, d) 
```
