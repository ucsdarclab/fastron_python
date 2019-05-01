# distutils: language = c++
# cython: language_level=3
import numpy
cimport numpy as np
from fastronWrapper_h cimport Fastron
from eigency.core cimport *

from cpython.ref cimport PyObject

cdef class PyFastron:
    cdef Fastron c_fastron

    def __cinit__(self, np.ndarray[np.float64_t, ndim=2] data):
        # type matters, must use float type
        #self.c_fastron = Fastron()
        #self.c_fastron = Fastron(Map[MatrixXd](data))
        self.c_fastron = Fastron(Map[MatrixXd](numpy.array(data,order='F')))
    
    # def __dealloc__(self):
    #     del self.c_fastron


    # Attribute access
    # model update parameters: gamma (kernel width), beta (conditional bias)
    @property
    def g(self):
        return self.c_fastron.g
    @g.setter
    def g(self, g):
        self.c_fastron.g = g

    @property
    def beta(self):
        return self.c_fastron.beta
    @beta.setter
    def beta(self, beta):
        self.c_fastron.beta = beta

      

    # max update iterations, max number of support points
    @property
    def maxUpdates(self):
        return self.c_fastron.maxUpdates
    @maxUpdates.setter
    def maxUpdates(self, maxUpdates):
        assert type(maxUpdates) == int
        self.c_fastron.maxUpdates = maxUpdates

    @property
    def maxSupportPoints(self):
        return self.c_fastron.maxSupportPoints
    @maxSupportPoints.setter
    def maxSupportPoints(self, maxSupportPoints):
        assert type(maxSupportPoints) == int
        self.c_fastron.maxSupportPoints = maxSupportPoints

    # Gram matrix and dataset of configurations
    @property
    def G(self):
        return ndarray(self.c_fastron.G)
    @G.setter
    def G(self, np.ndarray[np.float64_t, ndim=2] G):
        # type matters, must use float type
        self.c_fastron.G = Map[MatrixXd](numpy.array(G,order='F'))

    @property
    def data(self):
        return ndarray(self.c_fastron.data)
    @data.setter
    def data(self, np.ndarray[np.float64_t, ndim=2] data):
        # type matters, must use float type
        self.c_fastron.data = Map[MatrixXd](numpy.array(data,order='F'))

    # number of datapoints and dimensionality
    @property
    def N(self):
        return self.c_fastron.N
    @N.setter
    def N(self, N):
        assert type(N) == int
        self.c_fastron.N = N

    @property
    def d(self):
        return self.c_fastron.d
    @d.setter
    def d(self, d):
        assert type(d) == int
        self.c_fastron.d = d

    # weights, hypothesis, and true labels
    @property
    def alpha(self):
        return ndarray(self.c_fastron.alpha)
    @alpha.setter
    def alpha(self, np.ndarray[np.float64_t, ndim=2] alpha):
        # type matters, must use float type
        self.c_fastron.alpha = Map[ArrayXd](alpha)
    
    @property
    def F(self):
        return ndarray(self.c_fastron.F)
    @F.setter
    def F(self, np.ndarray[np.float64_t, ndim=2] F):
        # type matters, must use float type
        self.c_fastron.F = Map[ArrayXd](F)

    @property
    def y(self):
        return ndarray(self.c_fastron.y)
    @y.setter
    def y(self, np.ndarray[np.float64_t, ndim=2] y):
        # type matters, must use float type
        self.c_fastron.y = Map[ArrayXd](y)

    
    # functions and variables for model update
    def updateModel(self):
        self.c_fastron.updateModel()

    # def calculateMarginRemoved(self, idx):
    #     cdef int* idx_ptr = idx
    #     #cdef double max
    #     self.c_fastron.calculateMarginRemoved(idx_ptr)
    #     #return max
    # def computeGramMatrixCol(self, int idx, int startIdx):
    #     self.c_fastron.computeGramMatrixCol(idx, startIdx)

    # fastronWrapper/fastron.cpp:244:16: error: ‘Eigen::ArrayXd {aka class Eigen::Array<double, -1, 1>}’ has no member named ‘sign’; did you mean ‘sin’?
    # return acc.sign(); put the latest eigen under eigency'''

    # # perform proxy check
    # # TODO pointer does not work
    # def eval(self, np.ndarray[np.float64_t, ndim=2] query_points):
    #     cdef Map[MatrixXd]* ptr_query_points
    #     ptr_query_points = (&Map[MatrixXd](query_points))
    #     # cdef PyObject* ptr_query_points = <PyObject*>Map[MatrixXd](query_points)
    #     return ndarray(self.c_fastron.eval(ptr_query_points))#ptr_query_points))

    def eval(self, np.ndarray[np.float64_t, ndim=2] query_points):
        return ndarray(self.c_fastron.eval(Map[MatrixXd](numpy.array(query_points,order='F'))))

    # active learning parameters: allowance (number of new samples), kNS (number of points near supports), sigma (Gaussian sampling std), exploitP (proportion of exploitation samples)
    @property
    def allowance(self):
        return self.c_fastron.allowance
    @allowance.setter
    def allowance(self, allowance):
        assert type(allowance) == int
        self.c_fastron.allowance = allowance
    
    @property
    def kNS(self):
        return self.c_fastron.kNS
    @kNS.setter
    def kNS(self, kNS):
        assert type(kNS) == int
        self.c_fastron.kNS = kNS

    @property
    def sigma(self):
        return self.c_fastron.sigma
    @sigma.setter
    def sigma(self, sigma):
        self.c_fastron.sigma = sigma

    @property
    def exploitP(self):
        return self.c_fastron.exploitP
    @exploitP.setter
    def exploitP(self, exploitP):
        self.c_fastron.exploitP = exploitP

    def activeLearning(self):
        # self.c_fastron.activeLearning()
        return self.c_fastron.activeLearning()

    # kinematics-based collision detector
    # virtual function can not work, call kcd externally
    
    # update all labels in 
    def updateLabels(self, np.ndarray[np.float64_t, ndim=2] yKcd):
        self.c_fastron.updateLabels(Map[ArrayXd](yKcd))
