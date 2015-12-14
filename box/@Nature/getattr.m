function val = getattr(me, name, he)
% val = me.getattr(name, he)
% 获取名字为 name 的属性 2015-12-14
%
% 调用者 me, 是一个属性集对象(Nature)标量
% 可选参数，he，另一个对抗属性对象，在计算某些率时实际要取决于对方属性
%
% 算法逻辑：
% 1.如果某个属性缺省，则读取其参考属性
%   例 phyatk 不存在时，读取 atk 代替；注意 maxphyatk 有两个参考属性
% 2.各种率，命中率、闪避率、暴击率，可能还有由命中属性等转化而来的部分
% 3.不存在的属性，或无法确定的属性，返回0

if nargin < 3
    he = me;
end

val = me.get(name);

if isempty(val)
    gset = matfile(dfname('globalset'));
    attrreg = gset.attrreg;
    ref = attrreg{name, 'referto'};
    if iscell(ref), ref = ref{1}; end
    if ischar(ref) && ~isempty(ref)
        if strfind(ref, ';')
            ref = strsplit(ref, ';');
            for i = 1 : length(ref)
                val = me.get(ref{i});
                if ~empty(val)
                    break;
                end
            end
        else
            val = me.get(ref);
        end
    end
end

if isempty(val)
    val = 0;
end

% 计算率属性
if name(1) == 'r'
    gset = matfile(dfname('globalset'));
    attrreg = gset.attrreg;
    argme = attrreg{name, 'argme'};
    if iscell(argme), argme = argme{1}; end
    if ischar(argme) && ~isempty(argme)
        arghe = attrreg{name, 'arghe'};
        argbase = attrreg{name, 'argbase'};
        argcst = attrreg{name, 'argcst'};
        if iscell(arghe), arghe = arghe{1}; end
        if iscell(argbase), argbase = argbase{1}; end
        if iscell(argcst), argcst = argcst{1}; end

        % 己方属性
        argme = me.getattr(argme);

        % 基准属性
        if ischar(argbase) && ~isempty(argbase)
            % 免伤率基于对方的等级
            if strcmp(name(end-2:end), 'def')
                level = he.get('level');
            else
                level = me.get('level');
            end
            if isempty(level)
                level = 1;
            end
            attrbase = gset.attrbase;
            argbase = attrbase{level, argbase};
        else
            argbase = 0;
        end

        % 对抗方属性
        if ischar(arghe) && ~isempty(arghe)
            arghe = he.getattr(arghe);
        else
            arghe = 0;
        end

        % 公式常数
        if ischar(argcst) && ~isempty(argcst)
            cst = strsplit(argcst, ';');
            unit = gset.unit;
            cstA = unit.(cst{1});
            cstB = unit.(cst{2});
        else
            cstA = 1;
            cstB = 1;
        end

        if strcmp(name(end-2:end), 'def')
            rate = s_fracrate(max(argme - arghe, 0), argbase);
        elseif strcmp(name(end-2:end), 'bao')
            rate = s_fracrate(argme, arghe, cstA, cstB);
        else
            rate = s_fracrate(argme, argbase, cstA, cstB);
        end

        % 属性转化为额外率，可能也有直接率，则两部分相加
        val = val + rate;
    end
end

end %F main

%% subfunction
%
function rate = s_fracrate(attr, anti, m, n)

if nargin < 3
    m = 1;
end
if nargin < 4
    n = 1;
end

rate = m .* attr ./ (attr + n .* anti);

end %-of main

