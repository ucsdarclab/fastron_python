# distutils: language = c++

cimport numpy as np
from fastronWrapper_h cimport Fastron
from eigency.core cimport *


cdef class PyFastron:
    cdef Fastron c_fastron

    def __cinit__(self, np.ndarray[np.float64_t, ndim=2] data):
        #self.c_fastron = Fastron()
        self.c_fastron = Fastron(Map[MatrixXd](data))
    
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
    # TODO
    @property
    def G(self):
        print('a')
        #return ndarray(self.G)
    @G.setter
    def G(self, np.ndarray G):
        self.c_fastron.G = Map[MatrixXd](G)

    @property
    def data(self):
        print('a')
        #return ndarray(self.data)
    @data.setter
    def data(self, np.ndarray data):
        self.c_fastron.data = Map[MatrixXd](data)

    # number of datapoints and dimensionality
    @property
    def N(self):
        return self.c_fastron.N
    @N.setter
    def N(self, N):
        self.c_fastron.N = N

    @property
    def d(self):
        return self.c_fastron.d
    @d.setter
    def d(self, d):
        self.c_fastron.d = d


    # def get_area(self):
    #     return self.c_rect.getArea()

    # def get_size(self):
    #     cdef int width, height
    #     self.c_rect.getSize(&width, &height)
    #     return width, height