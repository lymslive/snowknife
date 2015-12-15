function var = loadto(target)
% var = loadto(target)
% 从目标文件中的目标变量中取出，返回给 var
% 参考 saveto(var, target)
%
% 如果 target 中未指定变量名，只有文件名，则以 struct 方式加载整个 mat 文件。
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
