% ���� tablemeta ���õ�����
% �ɹ����� true�������� false
% tablemeta �����õ� matfile ���������飬��Ҫ������ͬһ�� .mat ������һ��
% �㷨��
%   ��ȡ tablemeta �е�ÿһ�У��������ò����� excel ����һ�����
%   �����ѡ���������б���ת��
%   ��������ʱ stuct ����
%   ��󱣴�� struct �е����������
%   ����ѡ��Ϊ save(..., '-struct', '-append')
% ���������
%   tabnames: ��ָ�����벿�ֱ��ַ������ַ���Ԫ��
% ע�⣺
%   �Ը��ӷ�ʽ�����������Ҫ����ԭ .mat �ļ�����������ļ��е�ͬ������
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

    % �ѻ� .mat��������������
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

    % �������
    try
        rowname = tablemeta.rowname{i};
        tab.Properties.RowNames = tab.(rowname);
        tab.(rowname) = [];
    catch
        pass = true;
    end

    % ��ĳЩ��תΪ categorical
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

% �������һ��
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

% �޸���־:
% 2015-08-22: �Ż���ӡ��Ϣ���ֱ��ڶ� xls ǰ���ӡ����
% 2015-12-11: copy to ����Ŀ���Ż���ȡ·��
