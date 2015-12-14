function makemeta()
% 将 tablemeta.csv 转为 mat 数据文件，加速后续加载
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
