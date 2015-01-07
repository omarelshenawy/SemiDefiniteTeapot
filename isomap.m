N = 2048;
k = 12;
[x,~,t] = generate_data('swiss',N);
[~,ind]=sortrows(x);
t=t(ind,:);
x=x(ind,:);
da = x;
eta = calc_eta(da,k);
distMatrix = squareform(pdist(da));
%Create an edge matrix where element i,j is the euclidean distance if
%there is an edge between i and j, 0 if i=j, or inifinity otherwise
edgeMatrix = Inf(N,N);
edgeMatrix(eta==1) = distMatrix(eta==1);
edgeMatrix(eye(N)==1) = 0;
%Calculate the shortest path between each pair of edges along the
%graph. This uses Floyd-Warshall which runs in N^3, which is worse than
%Dijsktra which runs in N^2 log N. This could thus be improved.
S = allPairShortestPath(edgeMatrix);
S = S.^2;
%A magic formula given in Lawrence section 1.2.2 
transMatrix = eye(N) - ones(N,1)*ones(1,N);
G = -0.5*transMatrix*S*transMatrix;

%Run kernel PCA as usual:
p=kernelpca(da,2,G);
s = 10;
c = t(:,1)';
scatter(p(:,1),p(:,2),s,c);