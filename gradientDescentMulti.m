function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters, lambda)

m = length(y); % number of training examples
J_history = zeros(num_iters, 1);
n = size(X,2);

for iter = 1:num_iters

    grad = 1 / m * X' * (X * theta - y);
    grad(2:n) = grad(2:n) + lambda / m * sign(theta(2:n));
    theta = theta - alpha * grad;

    % Save the cost J in every iteration    
    J_history(iter) = computeCostMulti(X, y, theta, lambda);

end

end