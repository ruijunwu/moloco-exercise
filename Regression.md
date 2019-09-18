## Used the lasso regression to fit the data in column C in terms of colomn A, B, A^2, AB, B^2, A^3, A^2B, B^3. Some unimportant variables' parameters would be decreased to very small numbers. 
## And the best linear model should be: <br>
**y = -8.2651 + 11.3497 * A - 8.9645 * B - 67.1831 * A^2*B.**

```matlab
data = csvread('regress.csv',1,0);

X = data(:,1:2);
y = data(:,3);

%delete abnormal point
[minnum, pos] = min(y);
X(pos,:) = [];
y(pos) = [];


m = length(y);

A = X(:,1);
B = X(:,2);
X = [A B A.^2 A.*B B.^2 A.^3 A.^2.*B A.*B.^2 B.^3];

%X = [A B  A.^2.*B ];


[X mu sigma] = featureNormalize(X);

X = [ones(m, 1) X];

% Choose some alpha value
alpha = 0.1;
num_iters = 1000;
lambda = 1;

% Init Theta and Run Gradient Descent 
theta = zeros(size(X,2), 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters, lambda);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');


error = y - X * theta;
R2 = 1-sum(error.^2)/sum(y.^2);% use r^2 to test if our regression model is good enough or not

plot(y,predict,'b.','MarkerSize',15);
xlabel('true value');
ylabel('predicted value using lasso regression');
title('true value vs. predicted value');
```
-------------------------------------------------------------------------------------------------------------------

featureNormalize function is to normalize the training data:

```matlab
function [X_norm, mu, sigma] = featureNormalize(X)

X_norm = X;
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));


mu = mean(X, 1);
sigma = std(X, 1);
for i = 1:size(X,2)
    X_norm(:,i) = (X(:,i) - mu(i))/sigma(i);
end

end
```
-------------------------------------------------------------------------------------------------------------------
gradientDescentMulti function is to use gradient descent method to compute the theta(parameters) 
which minimize the cost function:
```matlab
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
```
-------------------------------------------------------------------------------------------------------------------
computeCostMulti is to compute every iterarion's cost function:

```matlab

function J = computeCostMulti(X, y, theta, lambda)

m = length(y); % number of training examples
n = size(X,2);

J = 0;

predictions = X * theta;
error = y - predictions;
J = 1/(2*m) * sum(error .^2) + lambda/(2*m) * sum(abs(theta(2:n)));

end
```


> This is my regression model result:

> ![alt text](https://github.com/ruijunwu/moloco-exercise/blob/master/lasso.jpg "result")

> Plot of convergence of the cost function:

> ![alt text](https://github.com/ruijunwu/moloco-exercise/blob/master/costfuction.jpg "costfunction")
