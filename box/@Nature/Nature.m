classdef Nature < hstruct
% 属性处理相关类
% 2015-12-14

methods %basic
function me = Nature(varargin)
me@hstruct(varargin{:});
end %F ctor
end %M

% 常量类数据
% 数据保存的位置
% 如 globalset.unit 表示保存在 globalset.mat 中名叫 unit 的变量
properties (Constant)
unit = 'globalset.unit';
argcst = 'globalset.unit';
attrbase = 'globalset.attrbase';
attrreg = 'globalset.attrreg';
end %P cst

end %C
