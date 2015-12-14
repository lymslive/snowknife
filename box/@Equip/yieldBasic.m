function tf = yieldBasic(me)
% 生成装备基础属性 2015-12-11
%
% 结果记录于 me.dsnattr, ranks * qualitys cell array
% 装备等级(20) by 品质个数(7) 个元胞矩阵
% 每个 cell 内容是形如 dispatch.basic 的表格 4*10
% 行是 4 个基本属性，列是十件装备

timeStart = tic;

% 读取其他设定数据
gset = matfile(dfname('globalset'));
unit = gset.unit;
lvgrow = gset.lvgrow;

Rankequip = me.get('Rankequip');
Quality = me.get('Quality');

rankCount = height(Rankequip);
qualityCount = height(Quality);

dsnattr = cell(rankCount, qualityCount);
for i = 1 : rankCount
    level = Rankequip.level(i);
    myunits = lvgrow.grow(level);
    myunits = myunits * me.get('basicWeight');

    for j = 1 : qualityCount
        qualityRate = Quality.rorange(j);

        tab = me.get('dispatch').basic;
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
timeUsed = toc(timeStart);
fprintf('Calculate equip basic attributes in field `dsnattr` , using time/s: %g', timeUsed);

tf = true;
end %F
