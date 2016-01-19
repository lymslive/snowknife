function outdmg = pipe(me, indmg)
% outdmg = me.pipe(indmg)
% 处理伤害流经该结点，一般是 x = kx + b 线性响应
%
% lymslive / 2015-12

outdmg = indmg * me.kScale + me.bAddition;

if outdmg < 0
    outdmg = 0;
end

end %F main
