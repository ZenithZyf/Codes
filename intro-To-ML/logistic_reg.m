function [ w, e_in ] = logistic_reg( X, y, w_init, max_its, eta )
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix (without an initial column of 1s)
%       y : data labels (plus or minus 1)
%       w_init: initial value of the w vector (d+1 dimensional)
%       max_its: maximum number of iterations to run for
%       eta: learning rate
    
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (as defined in LFD)
	
	k = 0;
	tic;
	weight = w_init;
% 	tolerance = 10^(-3);
	tolerance = 10^(-6);

	for num_iter = 1:max_its
	    data_matrix = [ones(size(X,1),1),X];
	    [num_train, dim_train] = size(data_matrix);

	    dividend = 1+exp(y.*(data_matrix*weight));
 
	    gradient_w = y.*data_matrix./dividend;
	    gradient_w = -sum(gradient_w)./num_train;

	    %set tolerance value here
	    if sum(abs(gradient_w)>=tolerance)==0
	    	k = 1;
	        break;
	    end

	    weight = weight+eta*(-transpose(gradient_w));
	end

    w = weight;

    e_in_temp = 0;
    for i = 1:num_train
        e_in_temp = e_in_temp+log(1+exp(-y(i)*data_matrix(i,:)*weight));
    end
    e_in = e_in_temp./num_train;

	toc;

	if k == 1
		fprintf('reach tolerance, terminate in %f tolerances', num_iter);
    else
        fprintf('terminate in %f tolerances', max_its);
	end
 
end

