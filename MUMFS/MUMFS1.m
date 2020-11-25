function [ G,P,B,Pi] = MUMFS1( X,param )
% Multi-view Unsupervised Multi-label Feature Selection
maxIter=40;
view_num = size(X.data,2);
[n, d] = size(X.fea);
%% ============================Normalization========================
for i = 1:view_num
    for  j = 1:n
        X.data{i}(j,:)=(X.data{i}(j,:)-mean(X.data{i}(j,:)))/std(X.data{i}(j,:));
    end
end
%% =========================Initialization==========================
% Initialize G
options = [];
options.Metric = 'HeatKernel';
options.NeighborMode = 'KNN';
options.WeightMode = 'Cosine';
options.k = 10;
for i = 1:view_num
    W1 = constructW(X.data{i},options);
    A{i}.data = W1;
end
temp_A = zeros(n, n);
for i=1:view_num
    temp_A = temp_A + A{i}.data;
end
G = temp_A/view_num;
% D1 = diag(sum(G));
% L = D1-G;
% initialize P
P = rand(d,param.l);
Pi = sqrt(sum(P.*P,2)+eps);
hh = 0.5./Pi;
H = diag(hh);
% initialize B,Z
B = randn(n,param.l)>0; B = B*1;
Z = randn(n,param.l)>0; Z = Z*1;
M = B-Z;
% epsil = 0.1;
%% ==========================Optimization===========================
iter = 1;
while iter <= maxIter
    % update alphav
    for v = 1:view_num
        alphav(v) = 0.5/norm(G-A{v}.data,'fro');
    end
    % update G
    dist = L2_distance_1(B',B');
    G = zeros(n);
    for i=1:n
        a0 = zeros(1,n);
        for v = 1:view_num
            temp = A{v}.data;
            a0 = a0+alphav(1,v)*temp(i,:);
        end
        idxa0 = find(a0>0);
        ai = a0(idxa0);
        di = dist(i,idxa0);
        ad = (ai-0.25*di)/sum(alphav);
        G(i,idxa0) = EProjSimplex_new(ad);
    end
    G = (G+G')/2;
    D1 = diag(sum(G));
    L = D1-G;
    % update P
    temp1 = inv(X.fea'*X.fea+param.beta*H);
    P = temp1*X.fea'*B;
    Pi = sqrt(sum(P.*P,2)+eps);
    hh = 0.5./Pi;
    H = diag(hh);
    % update B,Z,M,param.lambda
    Z = (sign(-param.mu*L*B+param.lambda*B+M)+1)/2;
    M = M+param.lambda*(B-Z);
    param.lambda = param.rhoo*param.lambda;
    temp2 = 2*param.alpha*X.fea*P-param.mu*L*Z+param.lambda*Z-M;
    B = (sign(temp2)+1)/2;
end






