%Scipt for calculating the amount of correctly classified instances,
%Anders. Phew

clear all 
close all
clc 
SDEerrorrate = 0;
Linearerrorrate = 0;
Polyerrorrate = 0;
Gaussianerrorrate = 0;
sigmaList = zeros(1,10);
for ii = 1:10
    Numbers ='89';
    filename = strcat('Large_Margin_',Numbers,'_',num2str(ii));
    load(filename)

    facit = testLabel([1:s2 end-s2+1:end],:); % True classes for the training points. 
    
    da = [data(1:810,:), trLabel([1:s end-s+1:end])];
    Training = data(1:810,:);
    TrainingLabels = trLabel([1:s end-s+1:end]);
    TestPoints = data(811:900,:);
    
    p=1;
    Kf = @(x,y) (x*y').^p+1;

    SVMStruct = svmtrain(Training,TrainingLabels,'kernel_function',Kf,'autoscale',false);
    groupLin = svmclassify(SVMStruct,TestPoints);
    
    p = 2; % For large margin
    Kf = @(x,y) (x*y').^p+1;
    SVMStruct = svmtrain(Training,TrainingLabels,'kernel_function',Kf,'autoscale',false);
    groupPoly = svmclassify(SVMStruct,TestPoints);
    
    
    [~, sigma]= calc_eta(data,4);
     
    sigmaList(ii) = sigma;
    gamma = 1/(2*sigma^2);
    Kf = @(x,y) rbf(x, y, sigma);
    SVMStructG = svmtrain(Training,TrainingLabels,'kernel_function',Kf,'autoscale',false);
    groupGauss = svmclassify(SVMStructG,TestPoints);

    SDEerrorrate = SDEerrorrate + sum(facit~=group)/length(facit);
    Linearerrorrate = Linearerrorrate + sum(facit~=groupLin)/length(facit);
    Polyerrorrate = Polyerrorrate + sum(facit~=groupPoly)/length(facit);
    Gaussianerrorrate = Gaussianerrorrate + sum(facit~=groupGauss)/length(facit);
    ii
end

SDEerrorrate = SDEerrorrate/10*100 % The average error rate in percent. 
Linearerrorrate = Linearerrorrate/10*100
Polyerrorrate = Polyerrorrate/10*100
Gaussianerrorrate = Gaussianerrorrate/10*100