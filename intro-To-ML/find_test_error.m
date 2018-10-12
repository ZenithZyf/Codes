function [ test_error ] = find_test_error( w, X, y )
%FIND_TEST_ERROR Find the test error of a linear separator
%   This function takes as inputs the weight vector representing a linear
%   separator (w), the test examples in matrix form with each row
%   representing an example (X), and the labels for the test data as a
%   column vector (y). X does not have a column of 1s as input, so that 
%   should be added. The labels are assumed to be plus or minus one. 
%   The function returns the error on the test examples as a fraction. The
%   hypothesis is assumed to be of the form (sign ( [1 x(n,:)] * w )

    [nums, dims] = size(X);
    num_mismatch = 0;

    for i = 1:nums
        s = [1, X(i,:)]*w;
        prob = exp(s)/(1+exp(s));

        if prob > 0.5
            pred = 1;
        else
            pred = -1;
        end

        if  pred ~= y(i)
            num_mismatch = num_mismatch+1;
        end
    end

    test_error = num_mismatch/nums;

end

