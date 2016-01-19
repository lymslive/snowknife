classdef damageNode < handle
% 伤害结点对象
% 
% lymslive/2015-12

% basic public members:
properties
% kx + b, 线性系数，与加法系数
kScale = 1;
bAddition = 0;
end %P

properties (Transient)
% 指向伤害源与伤害目标对象，便于利用它们的属性做计算
% 它们应该也是句柄对象，不需要时可留空
pSource = [];
pTarget = [];
end %P

% basic methods
methods

function me = damageNode(varargin)

switch nargin
% 允许空参数
case 0
    pass = true;

% 可传入一个一次多项式 [k, b]
% 或另一个 dN 对象，复制之
case 1
    arg = varargin{1};
    if isnumeric(arg)
        me.kScale = arg(1);
        me.bAddition = arg(2);
    elseif isa(arg, 'damageNode')
        me = arg.clone();
    elseif isstruct(arg)
        me = damageNode.fromStruct(arg);
    else
        error('damageNode@ctor: unknow input datatype');
    end

% 两个参数，k,b 分开传入 obj = damageNode(k, b)
case 2
    me.kScale = varargin{1};
    me.bAddition = varargin{2};

otherwise
    error('damageNode@ctor: input number wrong!');
end %switch

end %F ctor

function set.kScale(me, k)
if isnumeric(k) && numel(k) == 1 && k >= 0
    me.kScale = k;
else
    error('damageNode.kScale expect a nonnegative real number');
end
end %F set

function set.bAddition(me, b)
if isnumeric(b) && numel(b) == 1
    me.bAddition = b;
else
    error('damageNode.bAddition expect a real number');
end
end %F set

end %M

% Static methods
methods (Static)
obj = fromStruct(st);
end %M


end %Class
