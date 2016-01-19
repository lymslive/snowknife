function obj = fromStruct(st)
% 从 struct 创建对象
% 
% lymslive/2015-12
if ~isstruct(st) || numel(st) > 1
    error('damageNode.fromStruct() expect a scalar struct as input');
end

obj = damageNode(st.kScale, st.bAddition);
end %F main
