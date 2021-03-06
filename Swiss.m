sigma=1.45;
gamma = 1/(2*sigma^2);
% gamma = 0.1;
Kf = @(x,y)(exp(-(squareform(pdist(x,'euclidean')).^2)*gamma));
% da=dlmread('swissroll.dat');
% da = generate_data('swiss',300);
[x,~,t] = generate_data('swiss',800);
[~,ind]=sortrows(x);
t=t(ind,:);
x=x(ind,:);
da = x;
ker = Kf(da,da);
p=kernelpca(da,2,ker);
s = 10;
% c = linspace(1,10,length(p));
c = t(:,1)';
scatter(p(:,1),p(:,2),s,c);
% scatter(p(:,1),p(:,2))
% scatter3(da(:,1),da(:,2),da(:,3),s,c);
% 
%%
% data=dlmread('swissroll.dat');
[x,~,t] = generate_data('swiss',500);
[~,ind]=sortrows(x);
t=t(ind,:);
x=x(ind,:);
data = x;

data = data-repmat(mean(data),size(data,1),1);
eta=calc_eta(data,4);
[A,b]=Abfun(eta,data);
c=createC(data);
opt=struct('f',[],'l',[],'q',[],'r',[],'s',size(data,1));
[x,y,info]=sedumi(A,b,c,opt);
x=reshape(x,size(data,1),size(data,1));

%%
p=kernelpca(data,2,x);
figure;
s = 10;
% c = linspace(1,10,length(p));
c = t(:,1);
scatter(p(:,1),p(:,2),s,c);


EigenvaluesSDE = eig(x);
save('Swiss_Roll_Kernel_and_Eig2', 'x', 'EigenvaluesSDE', 'data')



