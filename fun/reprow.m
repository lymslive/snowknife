function out = reprow(A, n)
% 将矩阵 A 的每一行，重复 n 次，
% 内置函数 repmat(A, n, 1) 是将整个矩阵重复 n 次
%
% 2015-12-22

out = repmat(A, n, 1);
index = repmat([1 : size(A, 1)], n, 1);
index = index(:);
out = out(index, :);

end %F main
