function J = computeCostMulti(X, y, theta, lambda)

m = length(y); % number of training examples
n = size(X,2);

J = 0;

predictions = X * theta;
error = y - predictions;
J = 1/(2*m) * sum(error .^2) + lambda/(2*m) * sum(abs(theta(2:n)));

end