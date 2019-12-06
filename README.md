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

## Compile the Code

**NOTE: before compile, please read the issues section below**

To compile, run command:

```
python setup.py build_ext --inplace
```

## Issues
When trying to setup the Cython wrapper, compilation error may occur on some Eigen functions. This is because the bridge between numpy and Eigen, Eigency, maintains its own version of Eigen library and it is outdated. To fix this issue, replace that library with the latest Eigen library.

```
cd /tmp
curl -o eigen-3.3.7.tar.bz https://bitbucket.org/eigen/eigen/get/3.3.7.tar.bz2
tar -xvf eigen-3.3.7

# Need to rename it to eigen_3.2.8;
mv <untarred_directory> <conda_env>/lib/python3.7/site-packages/eigency/eigen_3.2.8
```
