function dkey = gendkeylist(kmain, ksub)
% ����˫���б� 2015-12-11
% kmain: ������������ֱ�ӵ��������������Ǳ����������� 1:kmain
% ksub: �μ���������ֱ�ӵĴμ����������Ǳ����������� 1:ksub
% dkey: �������о���
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
