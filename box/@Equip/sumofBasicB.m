function out = sumofBasicB(me)
% 统计固定装备的所有属性，该方法直接返回结果，table 类型
% 取每个等级中每件装备的属性和，在进阶点取进阶后的属性，即最大属性
%
% 2015-12-17
%

attr = me.get('dsnattrB');
out = htable(attr{1}.atlevels);
out = out.uniqueby('level');
levels = out(:, 'level');

out = htable(out(:, 3:end));

for i = 2 : length(attr)
    add = htable(attr{i}.atlevels);
    add = add.uniqueby('level');
    add = htable(add(:, 3:end));
    out = out + add;
end

out = [levels, out.table()];

end %F main
