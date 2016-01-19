function out = compose(me, rank, quality, equips)
% װ���ϳɣ�����ģ�⣬2015-12-21
%
% ���������
%   rank:  װ���Ƚ�
%   quality: Ʒ����ɫ��1-6
%   equips:  װ��������1*4 Ԫ��ÿ��Ԫ����ǰ׺���κ� 1-5
%     ��1��װ������װ������������Ǹ�װ�����������ļ���ȡǰ����ͬ��ǰ׺
%
% ���������
%   quality: �ϳ�����װ����Ʒ�ʣ���ʧ�ܣ�0��ֻ�����ǵ�ǰƷ�ʻ�+1Ʒ��
%   prequality: ����װ����ǰ׺
%    bug: ���� hstruct.subsref δ֧�ֶ෵�ز������ʺϲ����
%    out = [quality, prequality]
%
% ˵����
%   ���δ�ɹ������� []
%

% ǰ׺���ּ��������score = 2 ^ (prequality)
scorepower = 2;

if numel(equips) < 4
    equips(end+1 : 4) = equips(end);
end

% �жϺϳ��Ƿ�ɹ�
compsucc = me.get('compsucc');
succrate = compsucc.success(compsucc.rank == rank & compsucc.quality == quality);

r = rand();
if r > succrate
    out = [];
    return;
end

% ������֣���װ��������
score = scorepower^equips(1) + sum(scorepower .^equips);

% ��ȡ��ǰ���ֶε�ǰƷ�ʵĸ������������ĺ�10��
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

