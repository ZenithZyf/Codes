#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Nigel
"""

import numpy as np
from naivebayesPY import naivebayesPY
from naivebayesPXY import naivebayesPXY

def naivebayes(x, y, x1):
    """
    function logratio = naivebayes(x,y,x1);

    Computation of log P(Y|X=x1) using Bayes Rule
    Input:
    x : n input vectors of d dimensions (dxn)
    y : n labels (-1 or +1) (1xn)
    x1: input vector of d dimensions (dx1)

    Output:
    logratio: log (P(Y = 1|X=x1)/P(Y=-1|X=x1))
    """
    # Convertng input matrix x and x1 into NumPy matrix
    # input x and y should be in the form: 'a b c d...; e f g h...; i j k l...'
    X = np.matrix(x)
    X1= np.matrix(x1)
    
    # Pre-configuring the size of matrix X
    d, n = X.shape

    # fill in code here

    # get PY
    pos, neg = naivebayesPY(X, y)
    # get PXY
    posprob, negprob = naivebayesPXY(X, y)
    # get all features==1 in x1
    x1_fea = list(np.where(X1==1)[0])

    # positive condition
    poscond = np.prod([posprob[ii] for ii in x1_fea])*pos
    # negative condition
    negcond = np.prod([negprob[jj] for jj in x1_fea])*neg
    # logratio
    logratio = np.log(np.divide(poscond, negcond))
    
    return logratio
