function tf = genBasicB(me)
% ����̶�װ����8��������ʱ������ 
%
% ������ݽṹ˵����
% me.dsnattrB; 1*8 cell array, ÿ�� cell �Ǹ� strct
%  struct.equipid; 'eqxx'
%  struct.equipname; '����װ����'
%  struct.atlevels; һ�� tab��
%    ÿһ�б�ʾÿ���ȼ��µ����ԣ��ڽ��״����ظ��ȼ����ֱ��ʾ����ǰ���׺�����
%    ��3/4�У�level �ȼ���rank Ʒ�ף����1/2�����ԣ���ͬװ���������Բ�һ��
% 
% ����޸� : 2015-12-17
%

partB = {'eq04', 'eq05', 'eq06', 'eq07', 'eq08', 'eq09', 'eq10', 'eq11'};
nameB = {'����', '��ָ', '����', '����', 'ͷ��', '����', '����', 'Ь��'};

ebinit = me.get('ebinit');
ebgrow = me.get('ebgrow');
ebrankup = me.get('ebrankup');
eqlevel = me.get('equipLevel');

maxrank = height(eqlevel);

nrows = 200 + 19;
% colnames = ebgrow.Properties.VariableNames;
% ncols = length(colnames);
% �������򣬳���1��Ϊ rankid �⣬����Ϊ 'eq<��λ��><������>'

dsnattrB = cell(1, length(partB));
for i = 1 : length(partB)
    % �����Ӧ������
    eqname = partB{i};
    atfilter = ebinit{i,:} > 0;
    atnames = ebinit.Properties.VariableNames(atfilter);
    for j = 1 : length(atnames)
        atnames{j} = [eqname, atnames{j}];
    end

    initrow = ebinit(i,atfilter);
    initrow.Properties.RowNames = {};

    % �������Ա�
    tab = repmat(initrow, nrows, 1);
    % ����ǰ������ level rank, �ȼ���Ʒ�ʽ׼�
    pretab = array2table(zeros(nrows, 2), 'VariableNames', {'level', 'rank'});
    pretab{1, :} = ones(1,2);

    row = 1;
    level = 1;
    while true
        row = row + 1;

        % �����ɳ�������һ�������ϼӳɳ�ֵ���ɳ�ֵ��Ʒ���й�
        rank = pretab.rank(row-1);
        tab{row, :} = tab{row-1, :} + ebgrow{rank, atnames};

        level = level + 1;
        pretab.level(row) = level;
        pretab.rank(row) = rank;

        % �жϽ���
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

    % �������ݽṹ
    st = struct;
    st.equipid = partB{i};
    st.equipname = nameB{i};
    st.atlevels = [pretab, tab];

    dsnattrB{i} = st;

end

me.set('dsnattrB', dsnattrB);

tf = true;
end %F main
