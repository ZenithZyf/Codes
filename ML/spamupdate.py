def spamupdate(w,email,truth):

    # Input:
    # w     weight vector
    # email instance vector
    # truth label
    #
    # Output:
    #
    # updated weight vector
    #
    # INSERT CODE HERE:

    w = w+truth*email
    return w
