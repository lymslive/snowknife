function out = compose(me, rank, quality, equips)
% 装备合成，单次模拟，2015-12-21
%
% 输入参数：
%   rank:  装备等阶
%   quality: 品质颜色，1-6
%   equips:  装备向量，1*4 元，每个元素是前缀档次号 1-5
%     第1件装备是主装备，其后三次是辅装备，若不足四件，取前面相同的前缀
%
% 输出参数：
%   quality: 合成所得装备的品质，若失败，0，只可能是当前品质或+1品质
%   prequality: 所得装备的前缀
%    bug: 父类 hstruct.subsref 未支持多返回参数，故合并输出
%    out = [quality, prequality]
%
% 说明：
%   如果未成功，返回 []
%

% 前缀积分计算参数，score = 2 ^ (prequality)
scorepower = 2;

if numel(equips) < 4
    equips(end+1 : 4) = equips(end);
end

% 判断合成是否成功
compsucc = me.get('compsucc');
succrate = compsucc.success(compsucc.rank == rank & compsucc.quality == quality);

r = rand();
if r > succrate
    out = [];
    return;
end

% 计算积分，首装备计两次
score = scorepower^equips(1) + sum(scorepower .^equips);

% 获取当前积分段当前品质的概率向量，表格的后10列
gendsucc = me.get('gendsucc');
row = gendsucc(gendsucc.quality == quality ...
    & gendsucc.lbscore < score & score <= gendsucc.ubscore, :);
pvector = row{1, end-9:end};

r = rand();

index = weightfall(pvector, r);

if index > 5
    quality = quality + 1;
    prequality = index - 5;
else
    % quality = quality;
    prequality = index;
end

out = [quality, prequality];

end %F main

