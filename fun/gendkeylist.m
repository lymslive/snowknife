function dkey = gendkeylist(kmain, ksub)
% ����˫���б� 2015-12-11
% kmain: ��������
% ksub: �μ�����
% dkey: �������о���
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
