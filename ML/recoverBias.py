"""
INPUT:	
K : nxn kernel matrix
yTr : nx1 input labels
alphas  : nx1 vector or alpha values
C : regularization constant

Output:
bias : the scalar hyperplane bias of the kernel SVM specified by alphas

Solves for the hyperplane bias term, which is uniquely specified by the support vectors with alpha values
0<alpha<C
"""

import numpy as np

def recoverBias(K,yTr,alphas,C):
    bias = 0
    alphas = np.array(alphas)
    idx = np.argmin(np.abs(alphas - 0.5*C))

    n = yTr.shape[0]
    bias = (1.0/yTr[idx])-np.multiply(yTr.T, alphas.T).dot(K[:,idx])
    return bias 