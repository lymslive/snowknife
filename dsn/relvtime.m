% 升级节奏细化曲线
% 2015-12-10

% 先从 excel sheet 中导出带表头的 cell, dlvtime
tdlvtime = fcelltab(dlvtime);

% 过滤重复值
for i = height(tdlvtime)-1 : -1 : 1
    if tdlvtime.day(i) == tdlvtime.day(i+1)
        tdlvtime(i, :) = [];
    end
end

% 线性插值
roughtime = tdlvtime{:,:};
longtime = refine(roughtime);
