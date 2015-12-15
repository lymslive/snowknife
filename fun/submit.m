function tf = submit(file, name, val, varargin)
% 将一些变量保存至 .mat 数据文件
% tf = submit(file, name1, val1, name2, val2, ...)
%
% file, 提交至的文件名，不包含根路径与后缀名
% name-val，一对变量名与变量值，在文件中以 name 为名保存变量 val
% 可接收多对，但至少要有一对
%
% 返回布尔值表示成功与否，正确执行后返回 true
% file 与 name 都应该是合法的变量名，常规标量字符串
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
