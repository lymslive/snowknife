function plotBasicB(me)
% plotBasicB@Equip
% 绘制图形分析固定装备的基础属性曲线
% 数据取自 me.dsnattrB, 由 genBasicB() 方法计算而得
%
% 2015-12-17

%{ 项链与戒指的攻击曲线
s_plotOne(me, 1);
hold on;
s_plotOne(me, 2);
xlabel('level');
ylabel('atk');
grid on
legend('eq04', 'ep05');
hold off;
%}

%{ 玉佩与手镯的生命曲线
s_plotOne(me, 3);
hold on;
s_plotOne(me, 4);
xlabel('level');
ylabel('hp');
grid on
legend('eq06', 'ep07');
hold off;
%}

%{ 头盔与腰带的物防曲线
s_plotOne(me, 5, 1);
hold on;
s_plotOne(me, 6, 1);
xlabel('level');
ylabel('phydef');
grid on
legend('eq08', 'ep09', 'Location', 'northwest');
hold off;
%}

s_plotOne(me, 7, 1);
hold on;
s_plotOne(me, 8, 1);
xlabel('level');
ylabel('mgcdef');
grid on
legend('eq10', 'ep11', 'Location', 'northwest');
hold off;


end %F main

function s_plotOne(me, index, line)

tab = me.dsnattrB{index}.atlevels;

if nargin < 3
    line = 0;
end

figure(1);
plot(tab.level, tab.(3 + line));

% if width(tab) >= 4
    % figure(2)
    % plot(tab.level, tab.(4));
% end

end
