function out = reprow(A, n)
% ������ A ��ÿһ�У��ظ� n �Σ�
% ���ú��� repmat(A, n, 1) �ǽ����������ظ� n ��
%
% 2015-12-22

out = repmat(A, n, 1);
index = repmat([1 : size(A, 1)], n, 1);
index = index(:);
out = out(index, :);

end %F main
