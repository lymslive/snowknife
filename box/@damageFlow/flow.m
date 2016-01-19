function dmg = flow(me, origin)
% 计算该伤害流
% dmg = me.flow(origin)
% origin 参数可数，起始伤害，缺省为 0, 如此要求第一个结点是 +b 以驱动伤害流

if nargin < 2
    origin = 0;
end

dmg = origin;
for i = 1 : me.count
    dmg = me.top(i).pipe(dmg);
    if dmg <= 0
        break;
    end
end

end %F main
