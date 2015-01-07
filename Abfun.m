function [ A,b,M ] = Abfun( EtaM, Data) %Anders DD2434 Projectans
%Function for calulating A and B for our specific optimization porblem. 
% 

M = EtaM + (EtaM'*EtaM);
M = M - diag(diag(M));
[Indi, Indj] = find(M); %By belief: This will pick out all the interesting indexes. 

[MM, NN] = size(Data);
n = length(Indi);

A = sparse(n+1,MM*MM);
b = zeros(n+1,1);
A(n+1,:) = ones(1,MM*MM); %Criterion for sum to zero.

for ii = 1:n 
    Atemp = sparse(zeros(MM,MM));
    Atemp(Indi(ii), Indi(ii)) = 1;
    Atemp(Indj(ii), Indj(ii)) = 1;
    Atemp(Indi(ii), Indj(ii)) = -1;
    Atemp(Indj(ii), Indi(ii)) = -1;
    A(ii,:) = Atemp(:)';
    b(ii) = Data(Indi(ii),:)*Data(Indi(ii),:)' + ...
        Data(Indj(ii), :)*Data(Indj(ii),:)' - ...
        2*Data(Indi(ii), :)*Data(Indj(ii), :)';
   
    
end

end

