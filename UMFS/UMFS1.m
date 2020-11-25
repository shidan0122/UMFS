function [Z,G,P,B,Pi] = UMFS1( X,islocal,param )
% Unsupervised Multi-label Feature Selection
% X: d*n data matrix
% P: feature selection matrix
% B: binary multi-label matrix
% param.l : the length of binary multi-label
maxIter = 50; 
% epsil = 0.01;
[d,n] = size(X);
%% ========================Initialization==========================
% G
distX = L2_distance_1(X,X);
[distX1, idx] = sort(distX,2);
G = zeros(n);
rr = zeros(n,1);
for i = 1:n
    di = distX1(i,2:param.k+2);
    rr(i) = 0.5*(param.k*di(param.k+1)-sum(di(1:param.k)));
    id = idx(i,2:param.k+2);
    G(i,id) = (di(param.k+1)-di)/(param.k*di(param.k+1)-sum(di(1:param.k))+eps);
end;
% D = diag(sum(G));
% L = D-G;
param.sigma = mean(rr);
% P
P = randn(d,param.l);
Pi = sqrt(sum(P.*P,2)+eps);
hh = 0.5./Pi;
H = diag(hh);
% B,Z
B = randn(n,param.l)>0;
B = B*1;
Z = randn(n,param.l)>0;
Z = Z*1;
M = B-Z;
%% ==========================Optimization===========================
iter = 1;
while iter <= maxIter
    % optimize G
    distf = L2_distance_1(B',B');
    G = zeros(n);
    for i=1:n
        if islocal == 1
            idxa0 = idx(i,2:param.k+1);
        else
            idxa0 = 1:n;
        end;
        dfi = distf(i,idxa0);
        dxi = distX(i,idxa0);
        ad = -(dxi+0.5*param.mu*dfi)/(2*param.sigma);
        G(i,idxa0) = EProjSimplex_new(ad);
    end;
    G = (G+G')/2;
    D = diag(sum(G));
    L = D-G;
    % optimize P
    temp1 = inv(X*X'+param.beta*H);
    P = temp1*X*B;
    Pi = sqrt(sum(P.*P,2)+eps);
    hh = 0.5./Pi;
    H = diag(hh);
    % optimize B,Z,M,param.lambda
    Z = (sign(-param.mu*L*B+param.lambda*B+M)+1)/2;
    M = M+param.lambda*(B-Z);
    param.lambda = param.rhoo*param.lambda;
    temp2 = 2*param.alpha*X'*P-param.mu*L*Z+param.lambda*Z-M;
    B = (sign(temp2)+1)/2;
end
end





