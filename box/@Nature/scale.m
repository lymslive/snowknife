function me = scale(me, k, bhe)
% me.scale(k, bhe)
% 线性缩放自身属性，类似 me = me * k + bhe
% 其中 k 是个数字，将所有属性缩放 k 倍
% bhe 加法部分可选，是另一个 Natue/hstruct 或简单 struct
%
% 重载加法乘法的 plus mtimes 方法返回另一个对象
% scale 方法则直接修改对象本身的属性
%
% 2015-12-15
%
if nargin < 3
    she = me.mtimes(k);
else
    she = me.plus(me.mtimes(k), bhe);
end

me.stin_ = she.stin_;

end %F main
