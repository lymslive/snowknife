function fullpath = ppwd(subpath)
% ppwd: project print working directory
% ��ȡ��Ŀ·�����������Ŀ·������Ŀ¼תΪȫ·��
% �������Ǳ����ַ����������
% ���������з�ʽ���У��������з�ʽ����ֵͬ��ֻ�ܷ��ظ� ans
% ppwd sub
% x = ppwd('sub');
%
% 2015-12-11

basedir = 'E:\sgame\shuzhi';
if nargin < 1
    fullpath = basedir;
else
    fullpath = [basedir, filesep, subpath];
end

end %F
