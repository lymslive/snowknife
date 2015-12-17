function tf = genBasicB(me)
% 计算固定装备（8件）各级时的属性 
%
% 结果数据结构说明：
% me.dsnattrB; 1*8 cell array, 每个 cell 是个 strct
%  struct.equipid; 'eqxx'
%  struct.equipname; '中文装备名'
%  struct.atlevels; 一个 tab，
%    每一行表示每个等级下的属性，在进阶处将重复等级，分别表示进阶前进阶后属性
%    共3/4列，level 等级，rank 品阶，外加1/2列属性，不同装备所加属性不一样
% 
% 最后修改 : 2015-12-17
%

partB = {'eq04', 'eq05', 'eq06', 'eq07', 'eq08', 'eq09', 'eq10', 'eq11'};
nameB = {'项链', '戒指', '玉佩', '手镯', '头盔', '腰带', '护腿', '鞋子'};

ebinit = me.get('ebinit');
ebgrow = me.get('ebgrow');
ebrankup = me.get('ebrankup');
eqlevel = me.get('equipLevel');

maxrank = height(eqlevel);

nrows = 200 + 19;
% colnames = ebgrow.Properties.VariableNames;
% ncols = length(colnames);
% 列名规则，除第1列为 rankid 外，其余为 'eq<两位数><属性名>'

dsnattrB = cell(1, length(partB));
for i = 1 : length(partB)
    % 处理对应表列名
    eqname = partB{i};
    atfilter = ebinit{i,:} > 0;
    atnames = ebinit.Properties.VariableNames(atfilter);
    for j = 1 : length(atnames)
        atnames{j} = [eqname, atnames{j}];
    end

    initrow = ebinit(i,atfilter);
    initrow.Properties.RowNames = {};

    % 申请属性表
    tab = repmat(initrow, nrows, 1);
    % 申请前导表，加 level rank, 等级与品质阶级
    pretab = array2table(zeros(nrows, 2), 'VariableNames', {'level', 'rank'});
    pretab{1, :} = ones(1,2);

    row = 1;
    level = 1;
    while true
        row = row + 1;

        % 升级成长，在上一级基础上加成长值，成长值与品阶有关
        rank = pretab.rank(row-1);
        tab{row, :} = tab{row-1, :} + ebgrow{rank, atnames};

        level = level + 1;
        pretab.level(row) = level;
        pretab.rank(row) = rank;

        % 判断进阶
        if rank < maxrank && level >= eqlevel{rank+1, eqname}
            row = row + 1;
            tab{row, :} = tab{row-1, :} + ebrankup{rank, atnames};
            rank = rank + 1;
            pretab.level(row) = level;
            pretab.rank(row) = rank;
        end

        if level >= 200
            break;
        end
    end

    % 存入数据结构
    st = struct;
    st.equipid = partB{i};
    st.equipname = nameB{i};
    st.atlevels = [pretab, tab];

    dsnattrB{i} = st;

end

me.set('dsnattrB', dsnattrB);

tf = true;
end %F main
