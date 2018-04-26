close all;
%%Mínimos quadrados

%Definindo as funções de transferência

num1 = [0.5 2  2];
den1 = [1 3 4 2];
gs1 = tf(num1, den1);

u = ones(120,1);

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
title('Comparação entre os sistemas');

% Analise a resposta de ambos em função dos polos
%
%
%
%
%
%

%Coeficientes (Verificar)
a1=gz1.denominator{1,1};
b1=gz1.numerator{1,1};
a2=gz2.denominator{1,1};
b2=gz2.numerator{1,1};

a1 =  2.705;
a2 = 2.448;
a3 =  0.7408;
b1 = 0.05226;
b2 =  0.08553;
b3 = 0.035;

%Discretizando
gz1 = c2d(gs1,0.1);
gz2 = c2d(gs2,0.1);

y_gz1 = zeros(120,1);
y_gz2 = zeros(120,1);


%Ruido dinamico
e = randn((length(y_gz2)),1)*0.05;

% Equacao a diferença
for t=4:length(y_gz2)
    y_gz1(t) = -a1*y_gz1(t-1) -a2*y_gz1(t-2) -a3*y_gz1(t-3) + b1*u(t-1) + b2*u(t-2) + b3*u(t-3) + e(t);
    y_gz2(t) = -a1*y_gz2(t-1) -a2*y_gz2(t-2) -a3*y_gz2(t-3) + b1*u(t-1) + b2*u(t-2) + b3*u(t-3) + e(t);
end

%% Gerando valores simulados a partir da eq a diferenças para entradas diferentes;
% Processo de 2a ordem

m = input('ordem de u: ');
n = input('ordem de y: ');

%entradas
u = ones(100);
%u = (b - a)*rand(100, 1);

Y = [];
phi = [];

y(1:2) = 0; %Definindo condição inicial do sistema
u(1:2) = 0;

y(3:100) = y_gz2(1:98);

% Automatizando os regressores
for i = 3:length(u)
   for j = 1:n
       y_r(j) = y(i-j);
   end
   for k = 1:m
       u_r(k) = u(i-k);
   end
   % y1 = y(i-1);
   % y2 = y(i-2);
   % u1 = u(i-1);
   % u2 = u(i-2);
    Y = [Y; y(i)];
    phi = [phi; y_r u_r];
end

theta = inv(phi'*phi)*phi'*Y;


y_est(1:2) = 0;

a1 = theta(1);
a2 = theta(2);
b1 = theta(3);
b2 = theta(4);

for t=3:(length(y_gz2)+2)
    y_est(t) = -a1*y_est(t-1) -a2*y_est(t-2) + b1*u(t-1) + b2*u(t-2);
end

y_est = y_est(3:end);


figure;
plot(y_gz2);
hold on
plot(y_est)
title('Saída real x estimada');
legend('y real', 'y estimado');


%% Clear and Close
clear
clc


