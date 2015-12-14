function fullpath = dfname(data, ext)
% dfname: data file name.
% ��ȡ�����ļ���ȫ·��
% ���������data, ����Ҫ��׺������Ҫ���·��
% �÷������� mat/ ��Ŀ¼��Ѱ�� data.mat �ļ�
%
% ��ѡ���������ext ��׺������ͬ��׺�����ļ����ڲ�ͬ����Ŀ¼
% Ĭ�Ϻ�׺���� mat
%
% 2015-12-11

if nargin < 2
    ext = 'mat';
end

subdir = [ppwd(), filesep, ext];
fullpath = [subdir, filesep, data, '.', ext];

end %F
