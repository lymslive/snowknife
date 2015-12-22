function out = getRankat(me)
% 获得每件固定装备每阶的初始属性，即进阶后的属性
% 返回 8 个 cell，对就eq04-eq11，每个 cell 内容是个 table
% table 结构同 dsnattrB{i}.atlevels 的表格
%
% 2015-12-21

attr = me.get('dsnattrB');

out = cell(1, numel(attr));
for q = 1 : numel(attr)
    eqid = attr{q}.equipid;
    eqname = attr{q}.equipname;
    tab = attr{q}.atlevels;
    filter = [true; tab.rank(2:end) > tab.rank(1:end-1)];
    tab(~filter,:) = [];
    out{q} = tab;
end

end %F main
