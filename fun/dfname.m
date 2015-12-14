function fullpath = dfname(data, ext)
% dfname: data file name.
% 获取数据文件的全路径
% 输入参数：data, 不需要后缀，不需要相对路径
% 该方法将在 mat/ 子目录下寻找 data.mat 文件
%
% 可选额外参数，ext 后缀名，不同后缀名的文件放在不同的子目录
% 默认后缀名是 mat
%
% 2015-12-11

if nargin < 2
    ext = 'mat';
end

subdir = [ppwd(), filesep, ext];
fullpath = [subdir, filesep, data, '.', ext];

end %F
