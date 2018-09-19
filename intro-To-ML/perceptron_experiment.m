function [ num_iters bounds] = perceptron_experiment ( N, d, num_samples )
%perceptron_experiment Code for running the perceptron experiment in HW1
%   Inputs: N is the number of training examples
%           d is the dimensionality of each example (before adding the 1)
%           num_samples is the number of times to repeat the experiment
%   Outputs: num_iters is the # of iterations PLA takes for each sample
%            bounds is the theoretical bound on the # of iterations
%              for each sample
%      (both the outputs should be num_samples long)

num_iters = [];
bounds    = [];
for n = 1:num_samples
    
    %%% test data set initialization
    % generate random test samples: N*d (100*11 in this problem)
    training_set = [ones(N,1),-1+2.*rand(N,d)];
    % generate optimal set of weights
    weight_star  = [0; rand(d, 1)];
    % get the label for each data point
    label = transpose(weight_star)*transpose(training_set);
    label = transpose(sign(label));
    % generate data_in
    data_in = [training_set,label];
    
    % learn the weight and get the iterations using perceptron_learn
    [weight_learnt, iterations] = perceptron_learn(data_in);
    
    % calculate the bound
    weight_star_square = transpose(weight_star)*weight_star;
    for i = 1:N
        x_norm(i) = norm(training_set(i,2:d+1));
    end
    R = max(x_norm);    
    rho = min((transpose(weight_star)*transpose(training_set)).*transpose(label));
    
    bound = (R^2)*weight_star_square/(rho^2);
    
    num_iters = [num_iters,iterations];
    bounds = [bounds,bound];
end

end

