# distutils: language = c++
# cython: language_level=3

from eigency.core cimport *

from cpython.ref cimport PyObject

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

        # weights, hypothesis, and true labels
        Map[ArrayXd] alpha, F, y

        # functions and variables for model update
        void updateModel()
        # double calculateMarginRemoved(int *idx)
        # Map[ArrayXi] gramComputed
        # void computeGramMatrixCol(int idx, int startIdx)
        # void sparsify()

        # perform proxy check
        #Map[ArrayXd] eval(Map[MatrixXd] *ptr_query_points) # not work
        Map[ArrayXd] eval(Map[MatrixXd]) # overload

        # active learning parameters: allowance (number of new samples), kNS (number of points near supports), sigma (Gaussian sampling std), exploitP (proportion of exploitation samples)
        int allowance, kNS
        double sigma, exploitP
        # void activeLearning()
        double activeLearning()

        # kinematics-based collision detector
        # virtual function can not work, call kcd externally
        
        # update all labels in 
        void updateLabels(Map[ArrayXd])