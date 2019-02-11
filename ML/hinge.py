from numpy import maximum
import numpy as np


def hinge(w,xTr,yTr,lambdaa):
#
#
# INPUT:
# xTr dxn matrix (each column is an input vector)
# yTr 1xn matrix (each entry is a label)
# lambda: regression constant
# w weight vector (default w=0)
#
# OUTPUTS:
#
# loss = the total loss obtained with w on xTr and yTr
# gradient = the gradient at w

    # Loss function
    # the maximum part
    ywx   = yTr*np.matmul(np.transpose(w),xTr)
    max_p = np.sum(maximum(1-ywx,0))
    # the regularizer
    reg   = lambdaa*np.matmul(np.transpose(w),w)
    # the loss function
    loss  = max_p+reg

    # Gradient
    # the maximum part
    pos   = ywx<1
    g_max = np.matmul(-yTr*xTr,np.transpose(pos.astype(np.int)))
    # the regularizer part
    g_w   = 2*lambdaa*w
    # the gradient function
    gradient = g_max+g_w
    
    return loss,gradient
