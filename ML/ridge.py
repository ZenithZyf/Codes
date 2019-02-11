
import numpy as np


def ridge(w,xTr,yTr,lambdaa):
#
# INPUT:
# w weight vector (default w=0)
# xTr:dxn matrix (each column is an input vector)
# yTr:1xn matrix (each entry is a label)
# lambdaa: regression constant
#
# OUTPUTS:
# loss = the total loss obtained with w on xTr and yTr
# gradient = the gradient at w
#
# [d,n]=size(xTr);
   
    # Loss
    # the sum part
    wx   = np.matmul(np.transpose(w),xTr)
    sm   = np.sum(np.square(wx-yTr))
    # the regularizer
    reg  = lambdaa*np.sum(np.square(w))
    # the loss function
    loss = sm+reg

    # Gradient
    first    = np.matmul(xTr,np.transpose(wx-yTr))
    second   = lambdaa*w
    # the gradient function
    gradient = 2*(first+second)

    return loss,gradient