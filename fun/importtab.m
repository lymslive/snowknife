% 根据 tablemeta 配置导入表格
% 成功返回 true，出错返回 false
% tablemeta 中配置的 matfile 最好排序分组，将要保存在同一个 .mat 集中在一起
% 算法：
%   读取 tablemeta 中的每一行，据其配置参数从 excel 读入一个表格
%   处理可选的行名与列变量转换
%   保存在临时 stuct 域中
%   最后保存该 struct 中的所有域变量
%   保存选项为 save(..., '-struct', '-append')
% 输入参数：
%   tabnames: 可指定导入部分表，字符串或字符串元胞
% 注意：
%   以附加方式保存变量，不要覆盖原 .mat 文件，但会更新文件中的同名变量
function ST = importtab(tabnames)
ST = false;

base = ppwd();
matbase = [base, filesep, 'mat'];
metamat = [matbase, filesep, 'tablemeta.mat'];
load(metamat);

if nargin >= 1
    tablemeta = tablemeta(tabnames, :);
end

xlsdir = [base, filesep, 'xlsx'];

lastmat = '';
vars = struct;
count =height(tablemeta);
for i = 1 : count
    % short name
    name = tablemeta.Properties.RowNames{i};
    matfile = tablemeta.matfile{i};
    xlsfile = tablemeta.xlsfile{i};
    sheet = tablemeta.sheet{i};
    range = tablemeta.range{i};

    % 已换 .mat，保存上组数组
    if ~strcmp(matfile, lastmat)
        if ~isempty(lastmat) && ~isempty(fieldnames(vars))
            try
                save([matbase, filesep, lastmat '.mat'], '-struct', 'vars', '-append');
            catch
                save([matbase, filesep, lastmat '.mat'], '-struct', 'vars');
            end
            fprintf('save above tables in file: %s\n', [lastmat '.mat']);
        end
        vars = struct;
        lastmat = matfile;
    end

    fprintf('%2d/%d %s = [%s]%s!%s', i, count, name, xlsfile, sheet, range);
    fullpath = [xlsdir, filesep, xlsfile, '.xlsx'];
    tab = readtable(fullpath, 'Sheet', sheet, 'Range', range);

    % 添加行名
    try
        rowname = tablemeta.rowname{i};
        tab.Properties.RowNames = tab.(rowname);
        tab.(rowname) = [];
    catch
        pass = true;
    end

    % 将某些列转为 categorical
    try
        catfields = tablemeta.catfields{i};
        fields = regexp(catfields, '\s+', 'split');
        for f = 1 : length(fields)
            tab.(fields{f}) = categorical(tab.(fields{f}));
        end
    catch
        pass = true;
    end

    fprintf('\t%s\n', mat2str(size(tab)));
    vars.(name) = tab;

end

% 保存最后一组
if ~isempty(lastmat) && ~isempty(fieldnames(vars))
    try
        save([matbase, filesep, lastmat '.mat'], '-struct', 'vars', '-append');
    catch
        save([matbase, filesep, lastmat '.mat'], '-struct', 'vars');
    end
    fprintf('save above tables in file: %s\n', [lastmat '.mat']);
end

ST = true;
end %of main

% 修改日志:
% 2015-08-22: 优化打印信息，分别在读 xls 前后打印部分
% 2015-12-11: copy to 新项目，优化读取路径
