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