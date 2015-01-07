function [out,eigValue,eigVector] = kernelpca(in,dim,ker)
N=size(in,1);
oneN=ones(N,N)/N;
%centering
K=ker - oneN*ker - ker*oneN + oneN*ker*oneN;
% K=ker-ones(N,1)*mean(ker);
% K=ker;
%% eigenvalue analysis
[V,D] = svd(K);
eigVector = V;
eigValue = diag(D);
% [V,D]=eig(K);
% eigValue=diag(D);
% % [~,index]=sort(eigValue,'descend');
% % eigVector=V(:,index);
% eigVector = V;
%% normalization
% norm_eigVector=sqrt(sum(eigVector.^2));
% eigVector=eigVector./repmat(norm_eigVector,size(eigVector,1),1);

%% dimensionality reduction
eigVector=eigVector(:,1:dim);
eigValue=eigValue(1:dim);
eigVector = eigVector./(ones(N,1)*sqrt(eigValue)');
out=ker*eigVector;

end