function out = sumofBasicB(me)
% ͳ�ƹ̶�װ�����������ԣ��÷���ֱ�ӷ��ؽ����table ����
% ȡÿ���ȼ���ÿ��װ�������Ժͣ��ڽ��׵�ȡ���׺�����ԣ����������
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
