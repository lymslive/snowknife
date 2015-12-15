function she = mtimes(me, number)
% she = me * number
% 重载乘法操作，Nature 对象与一个标量数字相乘，每个属性与之相乘。
% 返回新生成的 Nature 对象。
%
% 注：并不检查 number 是否标量，传入数组的话，不会出错
% she 对象的每个属性都将是个数组。
%
% 2015-12-15

fields = me.fieldnames();

st = struct;
for i = 1 : numel(fields)
    st.(fields{i}) = me.get(fields{i}) * number;
end

she = Nature(st);
end %F
