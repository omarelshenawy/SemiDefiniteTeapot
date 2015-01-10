%Scipt for calculating the amount of correctly classified instances,
%Anders. 

clear all 
close all
clc 
SDEerrorrate = 0;
Linearerrorrate = 0;
Polyerrorrate = 0;
Gaussianerrorrate = 0;
for ii = 1:10
    Numbers ='12';
    filename = strcat('Large_Margin_',Numbers,'_',num2str(ii));
    load(filename)

    facit = testLabel([1:s2 end-s2+1:end],:);
    
    da = [data(1:810,:), trLabel([1:s end-s+1:end])];
    Training = data(1:810,:);
    TrainingLabels = trLabel([1:s end-s+1:end]);
    TestPoints = data(811:900,:);
    
    p=1;
    Kf = @(x,y)PolyKer( x,y,p);

    SVMStruct = svmtrain(Training,TrainingLabels,'kernel_function',Kf,'autoscale',false);
    groupLin = svmclassify(SVMStruct,TestPoints);
    
    size(groupLin)
%     p = 2; % For large margin
%     Kf = @(x,y)PolyKer( x,y,p);
%     ker = Kf(da,da);
%     
%     sigma = 1; % For large margin
%     gamma = 1/(2*sigma^2);
%     Kf = @(x,y)(exp(-(squareform(pdist(x,'euclidean').^2))*gamma));
%     ker = Kf(da,da);

    SDEerrorrate = SDEerrorrate + sum(facit~=group)/length(facit);
    Linearerrorrate = Linearerrorrate + sum(facit~=groupLin)/length(facit);
    Polyerrorrate = Polyerrorrate + sum(facit~=group)/length(facit);
    Gaussianerrorrate = Gaussianerrorrate + sum(facit~=group)/length(facit);
end

SDEerrorrate = SDEerrorrate/10*100 % The average error rate in percent. 
Linearerrorrate = Linearerrorrate/10*100
Polyerrorrate = Polyerrorrate/10*100
Gaussianerrorrate = Gaussianerrorrate/10*100