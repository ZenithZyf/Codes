"""
INPUT:	
K : nxn kernel matrix
yTr : nx1 input labels
C : regularization constant

Output:
Q,p,G,h,A,b as defined in cvxopt.solvers.qp

A call of cvxopt.solvers.qp(Q, p, G, h, A, b) should return the optimal nx1 vector of alphas
of the SVM specified by K, yTr, C. Just make these variables np arrays and keep the return 
statement as is so they are in the right format. See this reference to assign variables:
https://courses.csail.mit.edu/6.867/wiki/images/a/a7/Qp-cvxopt.pdf.
"""
import numpy as np
from cvxopt import matrix
from numpy.matlib import repmat

def generateQP(K, yTr, C):
    yTr = yTr.astype(np.double)
    n = yTr.shape[0]
    
    Q = np.multiply(yTr.dot(yTr.T), K).astype(np.double)
    p = (-1)*np.ones((n,1)).astype(np.double)

    G1 = np.identity(n).astype(np.double)
    G2 = -1*np.identity(n).astype(np.double)
    G = np.concatenate((G1, G2), axis=0)

    h1 = C*np.ones((n,1)).astype(np.double)
    h2 = np.zeros((n,1)).astype(np.double)
    h = np.concatenate((h1, h2), axis=0)

    A = yTr.T
    b = np.array([0]).astype(np.double)

    return matrix(Q), matrix(p), matrix(G), matrix(h), matrix(A), matrix(b)

