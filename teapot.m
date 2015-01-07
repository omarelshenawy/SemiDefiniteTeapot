data = importdata('teapots100.mat')';
data = data(1:100,:);
data = data-repmat(mean(data),size(data,1),1);

sigma=1.45;
gamma = 1/(2*sigma^2);
% gamma = 0.1;
Kf = @(x,y)(exp(-(squareform(pdist(x,'euclidean')))*gamma));
ker = Kf(data,data);
p=kernelpca(data,2,ker);
% scatter(p(:,1),p(:,2))


%%
eta=calc_eta(data,4);
[A,b]=Abfun(eta,data);
c=createC(data);
opt=struct('f',[],'l',[],'q',[],'r',[],'s',size(data,1));
[x,y,info]=sedumi(A,b,c,opt);
x=reshape(x,size(data,1),size(data,1));

%%
[p,eigValue,eigVector]=kernelpca(data,2,x);
eigValue
eigVector'
figure;
% s = 10;
% c = linspace(1,10,length(p));
% scatter(p(:,1),p(:,2),s,c);
scatter(p(:,1),p(:,2));
xlim([-30000,30000])
ylim([-30000,30000])
%save


