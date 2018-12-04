function [ train_err, test_err ] = AdaBoost( X_tr, y_tr, X_te, y_te, n_trees )
%AdaBoost: Implement AdaBoost using decision stumps learned
%   using information gain as the weak learners.
%   X_tr: Training set
%   y_tr: Training set labels
%   X_te: Testing set
%   y_te: Testing set labels
%   n_trees: The number of trees to use

% one entry for alpha; another entry for fitted trees.
trees = cell([2,n_trees]);

% switch the label from numbers to +1 or -1
char_num = unique(y_tr);
bi_y_train = (y_tr==char_num(1))+(-1)*(y_tr==char_num(2));
bi_y_test  = (y_te==char_num(1))+(-1)*(y_te==char_num(2));

% initialization
train_size = size(X_tr,1);
test_size  = size(X_te,1);
w_D = (1/train_size)*ones(train_size,1);

% train n_trees
for tt = 1:n_trees
	weak_le = fitctree(X_tr,bi_y_train,'MaxNumSplits',1,...
		'SplitCriterion','deviance','Weights',w_D);
	new_y = predict(weak_le,X_tr);
	eps_t = sum((new_y~=bi_y_train).*w_D);
	alpha_tt = 0.5*log((1-eps_t)/eps_t);
	trees{1,tt} = alpha_tt;
	trees{2,tt} = weak_le;
	alpha_exp = (new_y~=bi_y_train)*alpha_tt+(new_y==bi_y_train)*(-alpha_tt);
	w_D = w_D.*exp(alpha_exp);
	w_D = w_D/sum(w_D);
end

% get the training error
train_ysum = zeros(size(y_tr));
for ii = 1:n_trees
	alpha_ii = trees{1,ii};
	train_ysum = train_ysum+alpha_ii*predict(trees{2,ii},X_tr);
end
train_err = sum(sign(train_ysum)~=bi_y_train)/train_size;

% get the testing error
test_ysum = zeros(size(y_te));
for jj = 1:n_trees
	alpha_jj = trees{1,jj};
	test_ysum = test_ysum+alpha_jj*predict(trees{2,jj},X_te);
end
test_err = sum(sign(test_ysum)~=bi_y_test)/test_size;

end

