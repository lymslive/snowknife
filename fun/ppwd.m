function fullpath = ppwd(subpath)
% ppwd: project print working directory
% 获取项目路径，或将相对项目路径的子目录转为全路径
% 参数需是标量字符串，不检查
% 可用命令行方式运行，但命令行方式不能同值，只能返回给 ans
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
