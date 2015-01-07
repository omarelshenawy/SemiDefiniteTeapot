function [ ker ] = PolyKer( x,y,p)
%Polynomial Kernel

[n, ~] = size(x);
ker = zeros(n,n);

for i = 1:n
    for j = 1:n
        ker(i,j) = (x(i,:)*y(j,:)')^p+1;
    end
    
end

end

