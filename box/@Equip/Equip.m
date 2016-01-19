classdef Equip < hstruct
% 装备相关处理类
% 2015-12-11

properties (Constant)
defaultmat = 'equip';
end %P const

methods %basic
function me = Equip(varargin)
me@hstruct(varargin{:});
if nargin == 0
    me.stin_ = load(dfname(Equip.defaultmat));
else
end
end %F ctor
end %M

end %C
