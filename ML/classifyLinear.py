#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Nigel
"""

import numpy as np

def classifyLinear(x, w, b):
    """
    function preds=classifyLinear(x,w,b);

    Make predictions with a linear classifier
    Input:
    x : n input vectors of d dimensions (dxn)
    w : weight vector
    b : bias

    Output:
    preds: predictions
    """

    X = np.matrix(x)
    W = np.matrix(w)

    # fill in code here
    pred = np.matmul(np.transpose(W), X)+b
    preds = np.sign(pred)
    
    return preds
