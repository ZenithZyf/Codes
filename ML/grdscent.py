
import numpy as np
def grdescent(func,w0,stepsize,maxiter,tolerance=1e-02):
# INPUT:
# func function to minimize
# w_trained = initial weight vector
# stepsize = initial gradient descent stepsize
# tolerance = if norm(gradient)<tolerance, it quits
#
# OUTPUTS:
#
# w = final weight vector
    eps = 2.2204e-14 #minimum step size for gradient descent

    # go through first iteration
    iter = 1
    [loss, gradient] = func(w0)
    grad_norm = np.linalg.norm(gradient)
    if grad_norm>tolerance and stepsize>eps:
        w = w0-gradient*stepsize
        loss_last = loss
        gradient_last = gradient
    else:
        return w0
    
    # further iterations
    while iter<=maxiter and grad_norm>tolerance and stepsize>eps:
        iter = iter+1
        [loss, gradient] = func(w)
        grad_norm = np.linalg.norm(gradient)

        # decrease the loss function
        if loss_last>loss:
            stepsize = 1.01*stepsize
            w = w-gradient*stepsize
        else:
            w = w+gradient_last*stepsize
            stepsize = 0.5*stepsize
        
        loss_last = loss
        gradient_last = gradient

    # print("loss: %.2f%%" % loss)
    return w
