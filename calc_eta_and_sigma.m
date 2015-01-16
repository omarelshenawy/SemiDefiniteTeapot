function [eta sigma]= calc_eta(A,k)
    N = size(A,1);
    assert(N>k,'Cannot find %d neighbours in a set of only %d datapoints',k,N);
    distmatrix = squareform(pdist(A));
    eta = spalloc(N,N,k*N); %Preallocate a sparse matrix with k*N non-zero elements
    for i=1:N
        [~, sortIndex] = sort(distmatrix(i,:));
        eta(i,sortIndex(2:k+1)) = ones(1,k);
    end
    
    sigma = mean(mean( reshape(distmatrix(eta==1),4,N),1));
end