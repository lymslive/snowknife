function me = scale(me, k, bhe)
% me.scale(k, bhe)
% ���������������ԣ����� me = me * k + bhe
% ���� k �Ǹ����֣��������������� k ��
% bhe �ӷ����ֿ�ѡ������һ�� Natue/hstruct ��� struct
%
% ���ؼӷ��˷��� plus mtimes ����������һ������
% scale ������ֱ���޸Ķ����������
%
% 2015-12-15
%
if nargin < 3
    she = me.mtimes(k);
else
    she = me.plus(me.mtimes(k), bhe);
end

me.stin_ = she.stin_;

end %F main
