function [ train_set test_set ] = generate_dataset( Q_f, N_train, N_test, sigma )
%GENERATE_DATASET Generate training and test sets for the Legendre
%polynomials example
%   Inputs:
%       Q_f: order of the hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       sigma: standard deviation of the stochastic noise
%   Outputs:
%       train_set and test_set are both 2-column matrices in which each row
%       represents an (x,y) pair

x_train = unifrnd(-1,1,1,N_train);
x_test  = unifrnd(-1,1,1,N_test);

l_train = computeLegPoly(x_train,Q_f);
l_test  = computeLegPoly(x_test,Q_f);

for ord = 0:Q_f
	aq(ord+1) = random('norm',0,1);
end

eps_train = randn(1,N_train);
eps_test  = randn(1,N_test);

square_norm = 0;
for q = 0:Q_f
	square_norm = square_norm+1/(2*q+1);
end
norm_term = sqrt(square_norm);

norm_train = aq*l_train./norm_term;
norm_test  = aq*l_test./norm_term;

y_train = norm_train+sigma*eps_train;
y_test  = norm_test+sigma*eps_test;

train_set = [x_train',y_train'];
test_set  = [x_test',y_test'];

end