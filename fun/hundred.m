function c = hundred(n)
% ���� 1 : 100 �����������ڵȼ���
% ������һ��������� n�������������Ȱ� 100 ����

if nargin < 1
    n = 1;
end

c = [1 : 100 * n]';
end %F main
