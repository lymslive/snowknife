classdef Nature < hstruct
% ���Դ��������
% 2015-12-14

methods %basic
function me = Nature(varargin)
me@hstruct(varargin{:});
end %F ctor
end %M

% ����������
% ���ݱ����λ��
% �� globalset.unit ��ʾ������ globalset.mat ������ unit �ı���
properties (Constant)
unit = 'globalset.unit';
argcst = 'globalset.unit';
attrbase = 'globalset.attrbase';
attrreg = 'globalset.attrreg';
end %P cst

end %C
