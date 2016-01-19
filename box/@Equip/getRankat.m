function out = getRankat(me)
% ���ÿ���̶�װ��ÿ�׵ĳ�ʼ���ԣ������׺������
% ���� 8 �� cell���Ծ�eq04-eq11��ÿ�� cell �����Ǹ� table
% table �ṹͬ dsnattrB{i}.atlevels �ı��
%
% 2015-12-21

attr = me.get('dsnattrB');

out = cell(1, numel(attr));
for q = 1 : numel(attr)
    eqid = attr{q}.equipid;
    eqname = attr{q}.equipname;
    tab = attr{q}.atlevels;
    filter = [true; tab.rank(2:end) > tab.rank(1:end-1)];
    tab(~filter,:) = [];
    out{q} = tab;
end

end %F main
