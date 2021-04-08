 
% һά����
function result = Advance_Retreat_Gold(x0,d, t0, step, eps)
% ���˷��ͻƽ�ָȷ������
%=======================================================================
% ���룺
% x0����ǰ�㣻
% d����������
% t0�����˷��˵�ֵ��
% step�����˷�������
% eps���ƽ�ָ�ľ���
% �����
% result��������
%=======================================================================
% ���˷�ȷ����������
t1= t0 + step;
ft0 = BFGS_fun(x0, t0, d); % Ŀ�꺯��
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
% �ƽ�ָȷ����ȷ��
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
 