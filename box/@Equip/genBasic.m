function tf = genBasic(me)
% �������ɻ�װ���֣�3��װ�����ĸ�����Ʒ������ 2015-12-16
%
% ��������� me.dsnattr 20(�׼���*6��Ʒ�ʣ�cell
% ÿ�� cell �� 4*3 table������3��װ��������4�ֻ������ԣ�Ѫ��˫��

% ��ȡ�����趨����
gset = matfile(dfname('globalset'));
unit = gset.unit;
lvgrow = gset.lvgrow;

Rankequip = me.get('Rankequip');
Quality = me.get('Quality');
scalar = me.get('scalar');
% ��װ����
partA = {'eq01', 'eq02', 'eq03'};
% �̶���������
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
        % ��ȱʧ���� NaN ��Ϊ 0
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
