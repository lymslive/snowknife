function var = loadto(target)
% var = loadto(target)
% ��Ŀ���ļ��е�Ŀ�������ȡ�������ظ� var
% �ο� saveto(var, target)
%
% ��� target ��δָ����������ֻ���ļ��������� struct ��ʽ�������� mat �ļ���
%
% 2015-12-15
%
validateattributes(target, {'char'}, {'nonempty', 'row'}, mfilename, 'target');

target = strsplit(target, '.');
for i = 1 : numel(target)
    if ~isvarname(target{i})
        error('saveto: expect a valid varname string');
    end
end

filename = target{1};

if numel(target) >= 2
    mfile = matfile(dfname(filename));
    var = mfile.(target{2});
else
    var = load(dfname(filename));
end

end %F
