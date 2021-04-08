function x = Opt_BFGS(x0, Iter_max, eps)
% BFGS��ȷ��������������Ž�
%=======================================================================
% ���룺
% x0����ǰ�㣻
% Iter_max��������������
% eps���ƽ�ָ�ľ���
% �����
% x�����Ž⣻
%=======================================================================
ite = 1; % ѭ������
gk = BFGS_Gradient(x0); % ��ʼ�ݶ�
H = eye(length(x0)); % ��ʼH��
d = -gk*H'; % ��ʼ�������� 1 6, 6 6
alpha = Advance_Retreat_Gold(x0, d, 0,0.01, eps); % ��ʼ��������
while norm(gk) > eps && ite< Iter_max
x0 = x0 + alpha*d; % �µ�ѭ����
gkk = BFGS_Gradient(x0); % �µ��ݶ�
y = gkk - gk; % �ݶȲ�
s = alpha*d; % �������
H = H + (1 +(y*H*y')/(s*y'))*(s'*s)/(s*y') - (s'*y*H + H*y'*s)/(s*y'); 
%H�����
d = -gkk*H'; % �µ���������
alpha = Advance_Retreat_Gold(x0, d, 0,0.01, 1e-4); % �µ���������
gk = gkk; % �����ݶ�
ite = ite + 1; % ѭ��������1
end
x = x0 + alpha*d; % ��Сֵ
end
 