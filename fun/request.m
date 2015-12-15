function varargout = request(file, varargin)
% 从数据文件中获取变量
% varargout = request(file, varargin)
%
% file, 文件名，不包含路径与后缀
% varargin, 变量名列表，每个输入是一个字符串，如果原来有 cellstr，用 {:} 列出 
% varargout, 可接收多个变量，与 varargin 一一对应，多余的忽略可留空。
% 如果只有1个或0个输出参数接收多个变量，则打包返回 struct。
% 变量没有输入变量名，只有 file 文件名，则也返回加载的 struct。
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
