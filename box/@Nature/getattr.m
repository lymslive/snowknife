function val = getattr(me, name, he)
% val = me.getattr(name, he)
% ��ȡ����Ϊ name ������ 2015-12-14
%
% ������ me, ��һ�����Լ�����(Nature)����
% ��ѡ������he����һ���Կ����Զ����ڼ���ĳЩ��ʱʵ��Ҫȡ���ڶԷ�����
%
% �㷨�߼���
% 1.���ĳ������ȱʡ�����ȡ��ο�����
%   �� phyatk ������ʱ����ȡ atk ���棻ע�� maxphyatk �������ο�����
% 2.�����ʣ������ʡ������ʡ������ʣ����ܻ������������Ե�ת�������Ĳ���
% 3.�����ڵ����ԣ����޷�ȷ�������ԣ�����0

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

% ����������
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

        % ��������
        argme = me.getattr(argme);

        % ��׼����
        if ischar(argbase) && ~isempty(argbase)
            % �����ʻ��ڶԷ��ĵȼ�
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

        % �Կ�������
        if ischar(arghe) && ~isempty(arghe)
            arghe = he.getattr(arghe);
        else
            arghe = 0;
        end

        % ��ʽ����
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

        % ����ת��Ϊ�����ʣ�����Ҳ��ֱ���ʣ������������
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

