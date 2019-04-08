# Test FastronWrapper TestScript

from pprint import pprint

import numpy as np 
import fastronWrapper

# training set
N = 10000
d = 7
data = 2 * np.random.rand(N, d) - np.ones((N, d))

# test set
N_q = 3000
q = 1.5 * np.random.rand(N_q, d) - 0.75 * np.ones((N_q, d))
y_q = np.zeros((N_q, 1))
y_q_true = np.zeros((N_q, 1))


def kcd(query_point):
    return 2.0*(np.max(np.abs(query_point)) < 1) - 1.0


for i in range(N_q):
    y_q_true[i] = kcd(q[i,:])