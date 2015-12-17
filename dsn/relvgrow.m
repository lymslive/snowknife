function out = relvgrow()
% 细化成长单位表 2015-12-16
% 从 dlvgrow 计算 lvgrow，涉及存取 globalset.mat

mfile = matfile(dfname('globalset'), 'Writable', true);
dlvgrow = mfile.dlvgrow;

fields = {'level', 'grow'};
short = dlvgrow{:, fields};
option.plot = true;
long = refine(short, option);

if option.plot
    xlabel('level');
    ylabel('unit = f(n)');
    grid on;
end

if long(1,1) <= 0
    long(1, :) = [];
end

lvgrow = array2table(long, 'VariableNames', fields);

mfile.lvgrow = lvgrow;

out = lvgrow;
end %F main
