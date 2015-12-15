function she = plus(me, he, fields)
% she = me + he
% ���� Nature ����ӷ����أ������߶�Ӧ��ֵ��ӣ�������һ�� Nature ����
%
% he Ҳ�����Ǽ� struct �� hstruct ����
% ��ʽ���ÿɴ����������ѡ����
% fields, ֻ��ָ������ֵ��ӣ�str �� cellstr
% ȱʡ����£��� me �� he ���� Nature ����������ȡ������
% ����ֻ�� me �������
%
% 2015-12-15

if nargin >= 3
    if ischar(fields)
        fields = {fields};
    end
    if ~iscellstr(fields)
        error('plus@Nature expects a str or cellstr of scalar string');
    end
else
    if isa(he, 'Nature')
        fields = union(me.fieldnames(), he.fieldnames());
    else
        fields = me.fieldnames();
        if isstruct(he)
            he = Nature(he);
        end
        if ~isa(he, 'hstruct')
            error('plus@Nature can only add anthoer Nature/hstruct or struct');
        end
    end
end

st = struct;
for i = 1 : numel(fields)
    st.(fields{i}) = me.get(fields{i}) + he.get(fields{i});
end

she = Nature(st);

end %
