function x = Opt_BFGS(x0, Iter_max, eps)
% BFGS法确定多个变量的最优解
%=======================================================================
% 输入：
% x0：当前点；
% Iter_max：最大迭代次数；
% eps：黄金分割法的精度
% 输出：
% x：最优解；
%=======================================================================
ite = 1; % 循环次数
gk = BFGS_Gradient(x0); % 初始梯度
H = eye(length(x0)); % 初始H阵
d = -gk*H'; % 初始搜索方向 1 6, 6 6
alpha = Advance_Retreat_Gold(x0, d, 0,0.01, eps); % 初始搜索步长
while norm(gk) > eps && ite< Iter_max
x0 = x0 + alpha*d; % 新的循环点
gkk = BFGS_Gradient(x0); % 新的梯度
y = gkk - gk; % 梯度差
s = alpha*d; % 迭代点差
H = H + (1 +(y*H*y')/(s*y'))*(s'*s)/(s*y') - (s'*y*H + H*y'*s)/(s*y'); 
%H阵更新
d = -gkk*H'; % 新的搜索方向
alpha = Advance_Retreat_Gold(x0, d, 0,0.01, 1e-4); % 新的搜索步长
gk = gkk; % 更新梯度
ite = ite + 1; % 循环次数加1
end
x = x0 + alpha*d; % 极小值
end
 