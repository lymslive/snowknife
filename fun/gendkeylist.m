function dkey = gendkeylist(kmain, ksub)
% 生成双键列表 2015-12-11
% kmain: 主键个数，或直接的主键向量，若是标量，则生成 1:kmain
% ksub: 次键个数，或直接的次键向量，若是标量，则生成 1:ksub
% dkey: 返回两列矩阵
%

if numel(kmain) == 1
    kmain = (1 : kmain);
end

if numel(ksub) == 1
    ksub = (1 : ksub);
end

n = numel(kmain) * numel(ksub);
dkey = zeros(n, 2);

n = 0;
for m = kmain
    for s = ksub
        n = n + 1;
        dkey(n, 1) = m;
        dkey(n, 2) = s;
    end
end

end %F
