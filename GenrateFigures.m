% Created by Anders, because he needed something to work with. 

clear all
close all

%%
%load('Teapot_Kernel_and_Eig')
load('Teapot180_Kernel_and_Eig')
%load('Swiss_Roll_Kernel_and_Eig')
%load('Large_Margin_Kernel200')

%%
EigenvaluesSDE = eig(x);

%EigenvaluesSDE = eig(kern); % Large_Margin
eigenMatrix = zeros(3, length(EigenvaluesSDE));
eigenMatrix(4,:) = EigenvaluesSDE; 


p=1;
Kf = @(x,y)PolyKer( x,y,p);
da = data;
ker = Kf(da,da);
eigenMatrix(3,:) = sort(eig(ker), 'descend');

p=4;
%p = 2; % For large margin
Kf = @(x,y)PolyKer( x,y,p);
da = data;
ker = Kf(da,da);
eigenMatrix(2,:) = sort(eig(ker), 'descend');

%sigma = 1.45;
sigma = 1541; % For Teapot
%[~, sigma]= calc_eta_and_sigma(data,4)
%sigma = 5.5; % For large margin
gamma = 1/(2*sigma^2);
Kf = @(x,y)(exp(-(squareform(pdist(x,'euclidean').^2))*gamma));
da = data;
ker = Kf(da,da);
eigenMatrix(1,:) = sort(eig(ker), 'descend');

StackedBarPlot(eigenMatrix, 22) %26