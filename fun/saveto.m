function tf = saveto(var, target)
% tf = saveto(var, target)
% ������ var ������Ŀ�������ļ������� true/false ��ʾ�����ɹ����
%
% var, ���� matlab ����������ǳ������
% target, ���� filename.fieldname ��ʽ�������ַ���
%
% �� var �������� filename.mat ������ fieldname �ı�����
% ���ԭ���� fieldname ����Ҳ��һ�� struct �������� target �ַ������ټ�һ����
%
% 2015-12-15

validateattributes(target, {'char'}, {'nonempty', 'row'}, mfilename, 'target');

target = strsplit(target, '.');
for i = 1 : numel(target)
    if ~isvarname(target{i})
        error('saveto: expect a valid varname string');
    end
end

filename = target{1};
if numel(target) >= 2
    fieldname = target{2};
else
    fieldname = filename;
end

mfile = matfile(dfname(filename), 'Writable', true);
if numel(target) <= 2
    mfile.(fieldname) = var;
else
    oldvar = mfile.(fieldname);
    oldvar.(target{3}) = var;
    mfile.(fieldname) = oldvar;
    % �����εı�����д�ݲ�֧��
end

end %F
