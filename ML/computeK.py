"""
function K = computeK(kernel_type, X, Z)
computes a matrix K such that Kij=g(x,z);
for three different function linear, rbf or polynomial.

Input:
kernel_type: either 'linear','poly','rbf'
X: n input vectors of dimension d (dxn);
Z: m input vectors of dimension d (dxn);
kpar: kernel parameter (inverse kernel width gamma in case of RBF, degree in case of polynomial)

OUTPUT:
K : nxm kernel matrix
"""
import numpy as np
from l2distance import l2distance

def computeK(kernel_type, X, Z, kpar=0):
    assert kernel_type in ['linear', 'poly', 'rbf'], kernel_type + ' is an unrecognized kernel type in computeK'
    
    d, n = X.shape
    dd, m = Z.shape
    assert d == dd, 'First dimension of X and Z must be equal in input to computeK'
    
    K = np.zeros((n,m))

    # form the kernel
    if kernel_type == 'linear':
        K = np.dot(X.T, Z)
    elif kernel_type == 'poly':
        K = np.power(np.dot(X.T, Z)+1, kpar)
    elif kernel_type == 'rbf':
        K = np.exp(-kpar*np.power(l2distance(X, Z), 2))
    
    return K
