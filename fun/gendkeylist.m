function dkey = gendkeylist(kmain, ksub)
% 生成双键列表 2015-12-11
% kmain: 主键个数
% ksub: 次键个数
% dkey: 返回两列矩阵
%

n = kmain * ksub;
dkey = zeros(n, 2);

n = 0;
for s = 1 : ksub
    for m = 1 : kmain
        n = n + 1;
        dkey(n, 1) = m;
        dkey(n, 2) = s;
    end
end

end %F
