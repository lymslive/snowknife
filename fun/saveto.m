function tf = saveto(var, target)
% tf = saveto(var, target)
% 将变量 var 保存至目标数据文件，返回 true/false 表示操作成功与否
%
% var, 任意 matlab 变量，最好是常规变量
% target, 类似 filename.fieldname 格式，标量字符串
%
% 将 var 变量存入 filename.mat 中名叫 fieldname 的变量中
% 如果原来的 fieldname 变量也是一个 struct ，允许在 target 字符串中再加一个点
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
    % 更深层次的变量读写暂不支持
end

end %F
