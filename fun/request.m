function varargout = request(file, varargin)
% �������ļ��л�ȡ����
% varargout = request(file, varargin)
%
% file, �ļ�����������·�����׺
% varargin, �������б�ÿ��������һ���ַ��������ԭ���� cellstr���� {:} �г� 
% varargout, �ɽ��ն���������� varargin һһ��Ӧ������ĺ��Կ����ա�
% ���ֻ��1����0������������ն���������������� struct��
% ����û�������������ֻ�� file �ļ�������Ҳ���ؼ��ص� struct��
%
% 2015-12-15

varargout = cell(1, nargout);
file = dfname(file);

nvar = nargin - 1;
if nvar <= 0
    varargout{1} = load(file);
else
    mfile = matfile(file);
    if nargout <= 1
        if nvar == 1
            out = mfile.(varargin{1});
        else
            out = struct;
            for i = 1 : nvar
                out.(varargin{i}) = mfile.(varargin{i});
            end
        end
        varargout = {out};
    else
        for i = 1: min(nargout, nvar)
            varargout{i} = mfile.(varargin{i});
        end
    end
end

end %F
