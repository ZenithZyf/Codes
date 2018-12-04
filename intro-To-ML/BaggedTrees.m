function [ oobErr ] = BaggedTrees( X, Y, numBags )
%BAGGEDTREES Returns out-of-bag classification error of an ensemble of
%numBags CART decision trees on the input dataset, and also plots the error
%as a function of the number of bags from 1 to numBags
%   Inputs:
%       X : Matrix of training data
%       Y : Vector of classes of the training examples
%       numBags : Number of trees to learn in the ensemble
%
%   You may use "fitctree" but do not use "TreeBagger" or any other inbuilt
%   bagging function

train_size = size(X,1);
oob_err = zeros(1,numBags);

% switch the label from numbers to +1 or -1
char_num = unique(Y);
bi_y = (Y==char_num(1))+(-1)*(Y==char_num(2));

% loop numBags times
for iter = 1:numBags
	oob_predict = zeros(train_size,iter);

	for num_bag = 1:iter
		% sample train_size points from training data
		row_NO = randi(train_size,train_size,1);
		unique_row = unique(row_NO);

		% Training
		% generate a subset for training
		X_sub = X(unique_row,:);
		Y_sub = bi_y(unique_row);
		row = 1:train_size;
		% train a decision tree
		tree = fitctree(X_sub,Y_sub);

		% Testing
		% use the leftover trees for testing
		left_row = row';
		left_row(unique_row) = [];
		X_left = X(left_row,:);
		Y_left = bi_y(left_row);
		test_size = size(left_row,1);
		% test the decision tree
		pred = predict(tree,X_left);

		% save the result to a table
		for ii = 1:test_size
			oob_predict(left_row(ii),num_bag) = pred(ii);
		end
	end

	oob_predict = sum(oob_predict,2);
	oob_err(iter) = sum(sign(oob_predict)~=bi_y)/train_size;
end

oobErr = oob_err(end);

figure,
plot(oob_err,'LineWidth',2);
xlabel('number of bags');
ylabel('out of bag error');
title('numBags=200');
set(gca,'FontSize',20)
end
