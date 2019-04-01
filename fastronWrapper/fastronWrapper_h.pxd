# distutils: language = c++

from eigency.core cimport *

# cdef extern from "../fastron/src/fastron.cpp":
cdef extern from "fastron.cpp":
    pass

# Decalre the class with cdef
# cdef extern from "../fastron/include/fastron.h":
cdef extern from "fastron.h":
    cdef cppclass Fastron:
        # default construtor
        Fastron() except +  # must have a nullary constructor to be stack allocated

        # overload constructor
        Fastron(Map[MatrixXd]) except +
        
        # model update parameters: gamma (kernel width), beta (conditional bias)
        double g, beta  # Cannot assign default value to fields in cdef classes

        # max update iterations, max number of support points
        int maxUpdates, maxSupportPoints

        # Gram matrix and dataset of configurations
        # TODO
        Map[MatrixXd] G, data

        # number of datapoints and dimensionality
        int N, d
