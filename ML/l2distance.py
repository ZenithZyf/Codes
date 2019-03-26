import numpy as np
from numpy.matlib import repmat

"""
function D=l2distance(X,Z)
    
Computes the Euclidean distance matrix. 
Syntax:
D=l2distance(X,Z)
Input:
X: dxn data matrix with n vectors (columns) of dimensionality d
Z: dxm data matrix with m vectors (columns) of dimensionality d

Output:
Matrix D of size nxm 
D(i,j) is the Euclidean distance of X(:,i) and Z(:,j)
"""

def l2distance(X,Z=None):
    if Z is None:
        d, n = X.shape
        x2 = np.sum(np.power(X, 2), axis=0).reshape(n,1)
        xx = -2*np.dot(X.T, X)

        D1 = repmat(x2, 1, n)+xx+repmat(x2.T, n, 1)
        np.fill_diagonal(D1, 0)
        D = np.sqrt(np.maximum(D1, 0))

    else:
        d, n = X.shape
        dd, m = Z.shape
        assert d == dd, 'First dimension of X and Z must be equal in input to l2distance'
        D = np.zeros((n, m))
        
        x2 = np.sum(np.power(X, 2), axis=0).reshape(n,1)
        z2 = np.sum(np.power(Z, 2), axis=0).reshape(1,m)
        xz = -2*np.dot(X.T, Z)

        D1 = repmat(x2, 1, m)+xz+repmat(z2, n, 1)
        D = np.sqrt(np.maximum(D1, 0))
       
    return D
