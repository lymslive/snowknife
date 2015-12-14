function tf = yieldBasic(me)
% ����װ���������� 2015-12-11
%
% �����¼�� me.dsnattr, ranks * qualitys cell array
% װ���ȼ�(20) by Ʒ�ʸ���(7) ��Ԫ������
% ÿ�� cell ���������� dispatch.basic �ı�� 4*10
% ���� 4 ���������ԣ�����ʮ��װ��

timeStart = tic;

% ��ȡ�����趨����
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
