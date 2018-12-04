function [ overfit_m ] = computeOverfitMeasure( true_Q_f, N_train, N_test, var, num_expts )
%COMPUTEOVERFITMEASURE Compute how much worse H_10 is compared with H_2 in
%terms of test error. Negative number means it's better.
%   Inputs
%       true_Q_f: order of the true hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       var: variance of the stochastic noise
%       num_expts: number of times to run the experiment
%   Output
%       overfit_m: vector of length num_expts, reporting each of the
%                  differences in error between H_10 and H_2

for num = 1:num_expts
	sigma = sqrt(var);
	[train_set,test_set] = generate_dataset(true_Q_f,N_train,N_test,sigma);

	x_train = train_set(:,1);
	l_10 = computeLegPoly(x_train,10);
	l_2  = computeLegPoly(x_train,2);

	y_train = train_set(:,2);
	w_10 = glmfit(l_10',y_train,'normal','constant','off');
	w_2  = glmfit(l_2',y_train,'normal','constant','off');

	x_test = test_set(:,1);
	ltest_10 = computeLegPoly(x_test,10);
	ltest_2  = computeLegPoly(x_test,2);
	y_test = test_set(:,2);

	Eout_10 = mean((ltest_10'*w_10-y_test).^2);
	Eout_2  = mean((ltest_2'*w_2-y_test).^2);

	overfit_m = Eout_10-Eout_2;
end

end