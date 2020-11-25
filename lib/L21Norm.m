function l21_norm = L21Norm(X)
l21_norm = 0;
nRow = size(X,1);
for i = 1:nRow
    l21_norm = l21_norm + norm(X(i,:),2);
end
end

