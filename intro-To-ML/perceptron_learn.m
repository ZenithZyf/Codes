function [ w iterations ] = perceptron_learn( data_in )
%perceptron_learn Run PLA on the input data
%   Inputs: data_in: Assumed to be a matrix with each row representing an
%                    (x,y) pair, with the x vector augmented with an
%                    initial 1, and the label (y) in the last column
%   Outputs: w: A weight vector (should linearly separate the data if it is
%               linearly separable)
%            iterations: The number of iterations the algorithm ran for

%%% Variables initialization
examples   = 100; % set by the problem
iterations = 0;
label      = data_in(:,end); % get the label of y
data_learn = transpose(data_in(:,1:end-1)); % transpose x to column vector

rows = size(data_learn,1);
w    = zeros(rows,1);
h    = sign(transpose(w)*data_learn);

while ~isequal(transpose(h),label)
    iterations = iterations +1;
    for i = 1:examples
        if h(i) ~= label(i)
            % update w if misclassified
            w = w + label(i) * data_learn(:,i);
        end
    end
    h = sign(transpose(w)*data_learn);
end

end

