function tf = genBasic(me)
% 计算生成换装部分（3件装备）的各级各品质属性 2015-12-16
%
% 结果保存于 me.dsnattr 20(阶级）*6（品质）cell
% 每个 cell 是 4*3 table，列是3种装备，行是4种基础属性：血攻双防

% 读取其他设定数据
gset = matfile(dfname('globalset'));
unit = gset.unit;
lvgrow = gset.lvgrow;

Rankequip = me.get('Rankequip');
Quality = me.get('Quality');
scalar = me.get('scalar');
% 换装部分
partA = {'eq01', 'eq02', 'eq03'};
% 固定升级部分
partB = {'eq04', 'eq05', 'eq06', 'eq07', 'eq08', 'eq09', 'eq10', 'eq11'};

rankCount = height(Rankequip);
qualityCount = height(Quality);

dsnattr = cell(rankCount, qualityCount);
for i = 1 : rankCount
    level = Rankequip.level(i);
    myunits = lvgrow.grow(level);
    myunits = myunits * scalar.basicWeight/2;

    for j = 1 : qualityCount
        qualityRate = Quality.rorange(j);

        tab = me.get('disbasic');
        tab = tab(:, partA);
        % 将缺失数据 NaN 改为 0
        tab{:,:}(ismissing(tab)) = 0;
        for row = 1 : height(tab)
            vector = tab{row, :} / 100;
            atname = tab.Properties.RowNames{row};
            try
                atunit = unit.(atname);
            catch
                atunit = unit.def;
            end
            vector = vector * atunit * myunits * qualityRate;
            tab{row, :} = vector;
        end

        dsnattr{i, j} = tab;
    end
end

me.set('dsnattr', dsnattr);

tf = true;
end %F main
