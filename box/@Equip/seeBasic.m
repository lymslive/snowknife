function val = seeBasic(me, rank, quality)
% �鿴ĳ���ȼ�ĳ��Ʒ�ʵĻ������� 2015-12-11
% �����������Ӧ������

if nargin < 3
    disp('usage: obj.seeBasic(rank, quality)');
    val = [];
    return;
end
val = me.get('dsnattr'){rank, quality};
end %F
