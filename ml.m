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

%X = [A B A.^2 A.*B B.^2 A.^3 A.^2.*B A.*B.^2 B.^3];

X = [A B  A.^2.*B ]; 


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


predict = X * theta;
error = y - predict;
R2 = 1-sum(error.^2)/sum(y.^2); % use r^2 to test if our regression model is good enough or not

plot(y,predict,'b.','MarkerSize',15);
xlabel('true value');
ylabel('predicted value using lasso regression');
title('true value vs. predicted value');

theta
