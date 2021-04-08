 
% 一维搜索
function result = Advance_Retreat_Gold(x0,d, t0, step, eps)
% 进退法和黄金分割法确定步长
%=======================================================================
% 输入：
% x0：当前点；
% d：搜索方向；
% t0：进退法端点值；
% step：进退法步长；
% eps：黄金分割法的精度
% 输出：
% result：步长；
%=======================================================================
% 进退法确定大致区间
t1= t0 + step;
ft0 = BFGS_fun(x0, t0, d); % 目标函数
ft1 = BFGS_fun(x0, t1, d);
if ft1 <= ft0
step = 2*step;
t2 = t1 + step;
ft2 = BFGS_fun(x0, t2, d);
while ft1 > ft2
t1 = t2;
step = 2*step;
t2 = t1 + step;
ft1 = BFGS_fun(x0, t1, d);
ft2 = BFGS_fun(x0, 2, d);
end
else
step = step/2;
t2 = t1;
t1 = t2 - step;
ft1 = BFGS_fun(x0, t1, d);
while(ft1 > ft0)
step = step/2;
t2 = t1;
t1 = t2 - step;
ft1 = BFGS_fun(x0, t2, d);
end
end
a = 0;
b = t2;
% 黄金分割法确定精确解
a1 = a + 0.382*(b - a);
a2 = a + 0.618*(b - a);
f1 = BFGS_fun(x0, a1, d);
f2 = BFGS_fun(x0, a2, d);
while abs(b - a) >= eps
if f1 < f2
b = a2;
a2 = a1;
f2 = f1;
a1 = a + 0.382*(b - a);
f1 = BFGS_fun(x0, a1, d);
else
a = a1;
a1 = a2;
f1 = f2;
a2 = a + 0.618*(b - a);
f2 = BFGS_fun(x0, a2, d);
end
end;
result = 0.5*(a + b);
end
 