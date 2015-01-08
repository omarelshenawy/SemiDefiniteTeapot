% For calculating table 1, Anders
%%
aa = 1; %numbers to be compared
bb = 2;
n = 10;
for ii = 1:n
    [train, trLabel, test, testLabel]=loadBinaryUSPS(aa,bb);
    M = train;
    p = randperm(size(train,1));
    train = train(p,:);
    trLabel = trLabel(p,:);
    p2 = randperm(size(test,1));
    test = test(p2,:);
    testLabel = testLabel(p2,:);

    s = 405;
    s2 = 45;
    data = [train([1:s end-s+1:end],:);test([1:s2 end-s2+1:end],:)];
    data = data-repmat(mean(data),size(data,1),1);
    eta=calc_eta(data,4);
    [A,b]=Abfun(eta,data);
    c=createC(data);
    opt=struct('f',[],'l',[],'q',[],'r',[],'s',size(data,1));
    [x,y,info]=sedumi(A,b,c,opt);
    x=reshape(x,size(data,1),size(data,1));
    kern=x;

    Kfun = @(u,v)(kFun(u,v,kern));
    SVMStruct = svmtrain([1:length(trLabel([1:s end-s+1:end]))]',trLabel([1:s end-s+1:end]),'kernel_function',Kfun,'autoscale',false);

    group = svmclassify(SVMStruct,[length(trLabel([1:s end-s+1:end]))+1:length(data)]');

    filename = strcat('Large_Margin_',num2str(aa), num2str(bb),'_',num2str(ii))
    save(filename)
end