function out = relvgrow()
% ϸ���ɳ���λ�� 2015-12-16
% �� dlvgrow ���� lvgrow���漰��ȡ globalset.mat

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
