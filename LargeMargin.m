%%
[train, trLabel, test, testLabel]=loadBinaryUSPS(1,2);
s = 50;
data = [train([1:s end-s:end],:);test([1:s end-s:end],:)];
data = data-repmat(mean(data),size(data,1),1);
eta=calc_eta(data,4);
[A,b]=Abfun(eta,data);
c=createC(data);
opt=struct('f',[],'l',[],'q',[],'r',[],'s',size(data,1));
[x,y,info]=sedumi(A,b,c,opt);
x=reshape(x,size(data,1),size(data,1));
kern=x;

%%
Kfun = @(u,v)(kFun(u,v,kern));
SVMStruct = svmtrain([1:201]',trLabel([1:s end-s:end]),'kernel_function',Kfun,'autoscale',false);

%%
group = svmclassify(SVMStruct,[202:402]');