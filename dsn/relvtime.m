% ��������ϸ������
% 2015-12-10

% �ȴ� excel sheet �е�������ͷ�� cell, dlvtime
tdlvtime = fcelltab(dlvtime);

% �����ظ�ֵ
for i = height(tdlvtime)-1 : -1 : 1
    if tdlvtime.day(i) == tdlvtime.day(i+1)
        tdlvtime(i, :) = [];
    end
end

% ���Բ�ֵ
roughtime = tdlvtime{:,:};
longtime = refine(roughtime);
