function makemeta()
% �� tablemeta.csv תΪ mat �����ļ������ٺ�������
% 2015-12-11
%
base = ppwd();
metacsv = [base, filesep, 'xlsx', filesep, 'tablemeta.csv'];
metamat = [base, filesep, 'mat', filesep, 'tablemeta.mat'];

tablemeta = readtable(metacsv, 'ReadRowNames', true);
save(metamat, 'tablemeta');

fprintf('update: %s\n', metamat);

% clear tablemeta;

end %F
