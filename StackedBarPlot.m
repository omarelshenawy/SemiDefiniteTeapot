%Created by Anders, for his convenience
function [ fig ] = StackedBarPlot( eigenMatrix, seed )

rng(seed)
%eigenMatrix = eigenMatrix(:,1:5);
fig = figure;
hold on
a = jet;
[M, N] = size(eigenMatrix);
[MM,NN] = size(a);
r = randi([1,MM], 1, N);
colormatrix = zeros(N,3);
for i = 1:N
    colormatrix(i,:) = a(r(i),:);
end

if M > 1
    
    for ii = 1:M
       eigenMatrix(ii,:) =  eigenMatrix(ii,:)./sum(eigenMatrix(ii,:));

    end

    h =  barh(1:M, eigenMatrix, 'stacked');
end
%set(fig,'colormap', redbluecmap);


for i = 1:N;
    set(h(i), 'FaceColor', colormatrix(i,:), 'EdgeColor', colormatrix(i,:))
end
set(fig, 'Position', [300 300 900 400])

set(gca,'XTick',[0,0.2, 0.4, 0.6, 0.8, 1])
set(gca,'YTick',[1,2, 3, 4])

set(gca,'YTickLabel',{'Gaussian','Polynomial', 'Linear', 'SDE'})
xlim([0,1]);
end

