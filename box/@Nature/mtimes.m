function she = mtimes(me, number)
% she = me * number
% ���س˷�������Nature ������һ������������ˣ�ÿ��������֮��ˡ�
% ���������ɵ� Nature ����
%
% ע��������� number �Ƿ��������������Ļ����������
% she �����ÿ�����Զ����Ǹ����顣
%
% 2015-12-15

fields = me.fieldnames();

st = struct;
for i = 1 : numel(fields)
    st.(fields{i}) = me.get(fields{i}) * number;
end

she = Nature(st);
end %F
