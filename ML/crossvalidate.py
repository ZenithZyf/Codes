"""
INPUT:  
xTr : dxn input vectors
yTr : 1xn input labels
ktype : (linear, rbf, polynomial)
Cs   : interval of regularization constant that should be tried out
paras: interval of kernel parameters that should be tried out

Output:
bestC: best performing constant C
bestP: best performing kernel parameter
lowest_error: best performing validation error
errors: a matrix where allvalerrs(i,j) is the validation error with parameters Cs(i) and paras(j)

Trains an SVM classifier for all combination of Cs and paras passed and identifies the best setting.
This can be implemented in many ways and will not be tested by the autograder. You should use this
to choose good parameters for the autograder performance test on test data. 
"""

import numpy as np
import math
from trainsvm import trainsvm
from sklearn.model_selection import KFold

def crossvalidate(xTr, yTr, ktype, Cs, paras):
    bestC, bestP, lowest_error = 0, 0, 0
    errors = np.zeros((len(paras), len(Cs)))

    ns = 3
    kf = KFold(n_splits = ns)
    
    for i in range(len(Cs)):
        for j in range(len(paras)):
            for train_index, test_index in kf.split(yTr):
                x_train = xTr[:, train_index]
                y_train = yTr[train_index]
                svmclassify = trainsvm(x_train, y_train, Cs[i], ktype, paras[j])

                x_test = xTr[:, test_index]
                y_test = yTr[test_index]
                test_pred = svmclassify(x_test)

                errors[i,j] = errors[i,j]+np.mean(test_pred != y_test)
            errors[i,j] = errors[i,j]/ns

    ind = np.unravel_index(np.argmin(errors, axis=None), errors.shape)
    bestC = Cs[ind[0]]
    bestP = paras[ind[1]]
    lowest_error = errors[ind]
    
    return bestC, bestP, lowest_error, errors


    