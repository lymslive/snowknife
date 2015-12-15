function she = plus(me, he, fields)
% she = me + he
% 两个 Nature 对象加法重载，将两者对应域值相加，返回另一个 Nature 对象。
%
% he 也可以是简单 struct 或 hstruct 变量
% 显式调用可传入第三个可选参数
% fields, 只将指定的域值相加，str 或 cellstr
% 缺省情况下，若 me 与 he 都是 Nature 对象，则域名取并操作
% 否则，只按 me 的域集相加
%
% 2015-12-15

if nargin >= 3
    if ischar(fields)
        fields = {fields};
    end
    if ~iscellstr(fields)
        error('plus@Nature expects a str or cellstr of scalar string');
    end
else
    if isa(he, 'Nature')
        fields = union(me.fieldnames(), he.fieldnames());
    else
        fields = me.fieldnames();
        if isstruct(he)
            he = Nature(he);
        end
        if ~isa(he, 'hstruct')
            error('plus@Nature can only add anthoer Nature/hstruct or struct');
        end
    end
end

st = struct;
for i = 1 : numel(fields)
    st.(fields{i}) = me.get(fields{i}) + he.get(fields{i});
end

she = Nature(st);

end %
