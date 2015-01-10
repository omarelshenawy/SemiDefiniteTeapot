function K = rbf(U, V, sigma)
    if nargin < 3, sigma = 1; end
    %K = pdist2(U, V, 'euclidean').^2;
    K = bsxfun(@plus, sum(U.^2,2), sum(V.^2,2).') - 2*(U*V');
    K = exp(-K ./ (2*sigma^2));
end

