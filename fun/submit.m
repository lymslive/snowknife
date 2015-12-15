function tf = submit(file, name, val, varargin)
% ��һЩ���������� .mat �����ļ�
% tf = submit(file, name1, val1, name2, val2, ...)
%
% file, �ύ�����ļ�������������·�����׺��
% name-val��һ�Ա����������ֵ�����ļ����� name Ϊ��������� val
% �ɽ��ն�ԣ�������Ҫ��һ��
%
% ���ز���ֵ��ʾ�ɹ������ȷִ�к󷵻� true
% file �� name ��Ӧ���ǺϷ��ı���������������ַ���
%
% 2015-12-15

tf = false;

file = dfname(file);
mfile = matfile(file, 'Writable', true);
mfile.(name) = val;

for i = 1 : floor(length(varargin)/2)
    name = varargin{i*2 - 1};
    val = varargin{i*2};
    mfile.(name) = val;
end

tf = true;

end %F
