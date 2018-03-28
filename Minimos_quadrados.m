%%M�nimos quadrados

%Definindo as fun��es de transfer�ncia

num1 = [0.5 2  2];
den1 = [1 3 4 2];
gs1 = tf(num1, den1);

num2 = [2.5];
den2 = [1 1 2.5];
gs2 = tf(num2, den2);

% Entrada ao degrau

[y_gs1, t_gs1] = step(gs1,0:0.01:12);
[y_gs2, t_gs2] = step(gs2,0:0.01:12);

plot(t_gs1, y_gs1);
hold on;
plot(t_gs2, y_gs2);
legend('Sistema 1','Sistema 2');
title('Compara��o entre os sistemas');

% Analise a resposta de ambos em fun��o dos polos
%
%
%
%
%
%

% Discretizando

gz1 = c2d(gs1,0.1);
gz2 = c2d(gs2,0.1);
% Plotting 
figure;
[y_gz1, n_gz1] = step(gz1,0:0.1:12);
step(gs1,'k',gz1,'--')
title('Sistema 1');
legend('Cont�nuo','Discreto');
figure;
step(gs2,'r',gz2,'--')
title('Sistema 2');
legend('Cont�nuo','Discreto');

%% Gerando valores simulados a partir da eq a diferen�as para entradas diferentes;
% Processo de 2a ordem

u = ones(100);
Y = [];
phi = [];

y(1:2) = 0; %Definindo condi��o inicial do sistema
u(1:2) = 0;

y(3:100) = y_gz1(1:98);


for i = 3:length(u)
    y1 = y(i-1);
    y2 = y(i-2);
    u1 = u(i-1);
    u2 = u(i-2);
    Y = [Y; y(i)];
    phi = [phi; -y1 -y2 u1 u2];
end

theta = inv(phi'*phi)*phi'*Y;

for t=1:2
    y_est(t) = 0;
end

a1 = theta(1);
a2 = theta(2);
b1 = theta(3);
b2 = theta(4);

for t=3:(length(y_gz1)+2)
    y_est(t) = -a1*y_est(t-1) -a2*y_est(t-2) + b1*u(t-1) + b2*u(t-2);
end

y_est = y_est(3:end);


figure;
plot(y_gz1);
hold on
plot(y_est)
title('Sa�da real x estimada');
legend('y real', 'y estimado');


%% Clear and Close
clear
clc


