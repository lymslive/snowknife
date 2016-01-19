function c = hundred(n)
% 生成 1 : 100 向量，常用于等级列
% 可提升一个输入参数 n，将列向量长度按 100 缩放

if nargin < 1
    n = 1;
end

c = [1 : 100 * n]';
end %F main
