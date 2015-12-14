function val = seeBasic(me, rank, quality)
% 查看某个等级某个品质的基本属性 2015-12-11
% 两个输入参数应是整数

if nargin < 3
    disp('usage: obj.seeBasic(rank, quality)');
    val = [];
    return;
end
val = me.get('dsnattr'){rank, quality};
end %F
