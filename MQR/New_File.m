clear all
close all
clc
% Atividade 3 

num1=[0.5 2 2];
den1=[1 3 4 2];
g1=tf(num1,den1);
[y_g1, t1] = step(g1,12);


num2=[2.5];
den2=[1 1 2.5];
g2=tf(num2,den2);
[y_g2, t2] = step(g2,12);

gz1= c2d(g1,0.1);
gz2 = c2d(g2,0.1);
%u1=ones(1,length(y_g1))
%u1(1:length(y_g1)) = 1;
u1= -2*rand(length(y_g1), 1);
u1(1:3) = 0;
y1(1:3)=0;
a1=gz1.den{1,1};
b1=gz1.num{1,1};

for k=4:length(u1)
    y1(k)=-a1(2)*y1(k-1)-a1(3)*y1(k-2)-a1(4)*y1(k-3)+b1(2)*u1(k-1)+b1(3)*u1(k-2)+b1(4)*u1(k-3);
end
figure(1)
plot(y_g1)
hold on
plot(y1,'k')
title('Sistema 1');
legend('Curva Original','Aproximação Discreta')



y2(1:2)=0;
%u2(1:length(y_g2)) = 1;
u2= -2*rand(length(y_g2), 1);
u2(1:2) = 0;
a2=gz2.den{1,1};
b2=gz2.num{1,1};
for k=3:length(y_g2)
    y2(k)=-a2(2)*y2(k-1)-a2(3)*y2(k-2)+b2(2)*u2(k-1)+b2(3)*u2(k-2);
end

figure(2)
plot(y_g2)
hold on
plot(y2,'--k')
title('Sistema 2');
legend('Curva Original','Aproximação Discreta')

%% 2 questão Adicionando ruido
cemean(1:100)=0;
cemstd(1:100)=0;
%for g=1:100% Calculando 100 vezes

r2 = normrnd(0,0.05,1,length(y2));
r1 = normrnd(0,0.05,1,length(y1));
%r2 = randn(1,(length(y2)))*0.05;
%r1 = randn(1,(length(y1)))*0.05;

y1_rd(1:3)=0;
for k=4:length(u1)
    y1_rd(k)=-a1(2)*y1_rd(k-1)-a1(3)*y1_rd(k-2)-a1(4)*y1_rd(k-3)+b1(2)*u1(k-1)+b1(3)*u1(k-2)+b1(4)*u1(k-3) + r1(k);
end
y2_rd(1:2)=0;
for k=3:length(y_g2)
    y2_rd(k)=-a2(2)*y2_rd(k-1)-a2(3)*y2_rd(k-2)+0.01207*u2(k-1)+0.01167*u2(k-2) + r2(k);
end

y1_rs = y1 + r1;
y2_rs = y2 + r2;
y1_rs(1:3) = zeros(1,3);
y2_rs(1:2) = zeros(1,2);


% EstimaÃ§Ã£o
% Para y1

Ny = 3;
Nu = 3;
[phi, Y] = montaRegressoresLinear(length(u1),Ny,Nu,y1_rd,u1);

theta = inv(phi'*phi)*phi'*Y;

y1_est(1:3) = 0;

%ordem 3
aaa1 = -theta(1);
aaa2 = -theta(2);
aaa3 = -theta(3);
bbb1 = theta(4);
bbb2 = theta(5);
bbb3 = theta(6);

for t=4:(length(u1))
    
    y1_est(t) = -aaa1*y1_est(t-1) -aaa2*y1_est(t-2) -aaa3*y1_est(t-3) + bbb1*u1(t-1) + bbb2*u1(t-2) + bbb3*u1(t-3);
end

%cemean(g)=mean(y1_est);
%cemstd(g)=std(y1_est);

%end;


figure
plot(y1);
hold on;
plot(y1_est);

%Para y2

Ny2 = 2;
Nu2 = 2;
%y2(3:127) = y2(1:125);
%y2(1:2) = 0;
[phi2, Y2] = montaRegressoresLinear(length(u2),Ny2,Nu2,y2_rs,u2);
theta2 = inv(phi2'*phi2)*phi2'*Y2;

y2_est(1:2) = 0;

aa1 = -theta2(1);
aa2 = -theta2(2);
bb1 = theta2(3);
bb2 = theta2(4);


for t=3:(length(u2))
    y2_est(t) = -aa1*y2_est(t-1) -aa2*y2_est(t-2) + bb1*u2(t-1) + bb2*u2(t-2);
end

figure
plot(y2);
hold on;
plot(y2_est);



%% 3a Validar

%Gerando u_v
u1_v= -2*rand(length(y1), 1);
u2_v= -2*rand(length(y2), 1);
u1_v(1:3) = 0;
u2_v(1:2) = 0;

%Gerando y_v
y1_v(1:3)=0;
for k=4:length(u1)
    y1_v(k)=-a1(2)*y1_v(k-1)-a1(3)*y1_v(k-2)-a1(4)*y1_v(k-3)+b1(2)*u1_v(k-1)+b1(3)*u1_v(k-2)+b1(4)*u1_v(k-3);
end
y2_v(1:2)=0;
for k=3:length(y_g2)
    y2_v(k)=-a2(2)*y2_v(k-1)-a2(3)*y2_v(k-2)+b2(2)*u2_v(k-1)+b2(3)*u2_v(k-2);
end

% Matriz phi
[phi1_v, Y1_v] = montaRegressoresLinear(length(u1_v),Ny,Nu,y1_v,u1_v);
[phi2_v, Y2_v] = montaRegressoresLinear(length(u2_v),Ny2,Nu2,y2_v,u2_v);

y1_val = phi1_v * theta;
y2_val = phi2_v * theta2;

% Erro de validação
e1_v = y1_v - y1_val;
e2_v = y2_v - y2_val;

% SEQ de y1
SEQ1=0;
for k=1:(length(u1)-6)
    SEQ1=(y1_v(k)-y1_val(k)')^2;
end;
% SEQM de y1
SEQM1=0;
for k=1:(length(u1)-6)
    SEQM1=1/k*((y1_v(k)-y1_val(k)')^2);
end;

% SEQ de y2
SEQ2=0;
for k=1:(length(u2)-2)
    SEQ2=(y2_v(k)-y2_val(k)')^2;
end;
% SEQM de y2
SEQM2=0;
for k=1:(length(u2)-2)
    SEQM2=1/k*((y2_v(k)-y2_val(k)')^2);
end;

% Coeficientes de correlação Multipla


for k=1:(length(u1)-6)
R1=sqrt(1-(((y1_v(k)-y1_val(k))^2)/(y1_v(k)-mean(y1_v))^2));
end;

for k=1:(length(u2)-2)
R2=sqrt(1-(((y2_v(k)-y2_val(k))^2)/(y2_v(k)-mean(y2_v))^2));
end;

%% 4 ARX ARMAX
% Dados 1

a = dlmread('dados_2.txt');
u = a(:,2)'; %u(t)
y = a(:,1)'; %y(t)
y1 = y;
Ny = 1;
Nu = 1;
[phi, Y] = montaRegressoresLinear(length(u),Ny,Nu,y,u);
theta = inv(phi'*phi)*phi'*Y;
y_estarx = phi*theta;
%%
y1 = y;
Ny = 5;
Nu = 5;
[phi, Y] = montaRegressoresLinear(length(u),Ny,Nu,y,u);
theta = inv(phi'*phi)*phi'*Y;
y_estarx = phi*theta;

%% Minimos quadrados estendido (ARMAX)

clear,clc,
close all

a = dlmread('dados_1.txt');
u = a(:,2)'; %u(t)
y = a(:,1)'; %y(t)
N = length(y);
n = 2; %Ordem

%Dividindo os pares entrada-saida para estimacao e validacao
y_e = y(1:(N/2));
y_v = y((N/2):N);
u_e = u(1:(N/2));
u_v = u((N/2):N);

lambda = 1;
p = 1000*eye(n*3,n*3);
theta = zeros(n*3,1);


for t=1:(n*3)
    y_e(t) = 0;
    w(t) = 0;
    erro(t)= 0;
end

for t=(n*3):(N/2)
    phi = [-y_e(t-1); -y_e(t-2); u(t-1); u(t-2); w(t-1); w(t-2)];
    erro(t) = y_e(t) - theta'*phi;
    k = p*phi/(lambda+phi'*p*phi);
    theta = theta+k*erro(t);
    p = (p-k*phi'*p)/lambda;
    w(t) = y_e(t)-theta'*phi;
end

for t = (n*3):(N/2)
    y_est(t) = -theta(1)*y_e(t-1) - theta(2)*y_e(t-2) + theta(3)*u(t-1) + theta(4)*u(t-2);
end
    
plot(y_e);
hold on;
plot(y_est);


%Validacao

lambda = 1;
p = 1000*eye(n*3,n*3);
theta_v = zeros(n*3,1);

for t=1:(n*3)
    y_v(t) = 0;
    w_v(t) = 0;
    erro_v(t)= 0;
end

% Matriz phi

for t=(n*3):(N/2)
    phi_v = [-y_v(t-1); -y_v(t-2); u_v(t-1); u_v(t-2); w_v(t-1); w_v(t-2)];
    erro_v(t) = y_v(t) - theta_v'*phi_v;
    k = p*phi_v/(lambda+phi_v'*p*phi_v);
    theta_v = theta_v+k*erro_v(t);
    p = (p-k*phi_v'*p)/lambda;
    w_v(t) = y_v(t)-theta_v'*phi_v;
end

y_val = phi_v' * theta;

% Erro de validação
e1_v = y_v - y_val;
