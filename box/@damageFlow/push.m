function me = push(me, varargin)
% 检查推入 damageFlow 的是否合法 damageNode 对象

if ~isempty(varargin)
    val = varargin{end};
    if ~isa(val, 'damageNode')
        error('damageFlow can only contain damageNode object');
    end
end

me.push@cList(varargin{:});

end %F 
