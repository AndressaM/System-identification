clear all
close all
clc
% Atividade 3 

num1=[0.5 2 2];
den1=[1 3 4 2];
g1=tf(num1,den1);
[y_g1, t1] = step(g1);


num2=[2.5];
den2=[1 1 2.5];
g2=tf(num2,den2);
[y_g2, t2] = step(g2);

gz1= c2d(g1,0.1);
gz2 = c2d(g2,0.1);
%%
u1(1:length(y_g1)) = 1;
%u1= -2*rand(81, 1);
y1(1:3)=0;
a1=gz1.denominator{1,1};
b1=gz1.numerator{1,1};
for k=4:length(u1)
    y1(k)=-a1(2)*y1(k-1)-a1(3)*y1(k-2)-a1(4)*y1(k-3)+b1(2)*u1(k-1)+b1(3)*u1(k-2)+b1(4)*u1(k-3);
end
figure(1)
plot(y_g1, 'k:')
hold on
plot(y1)



y2(1:2)=y_g2(1:2);
u2(1:length(y_g2)) = 1;
a2=gz2.denominator{1,1};
b2=gz2.numerator{1,1};
for k=3:length(y_g2)
    y2(k)=-a2(2)*y2(k-1)-a2(3)*y2(k-2)+b2(2)*u2(k-1)+b2(3)*u2(k-2);
end

figure(2)
plot(y_g2, 'k:')
hold on
plot(y2)

% Adicionando ruido
r2 = normrnd(0,0.05,1,127);
%r2 = randn(1,(length(y2)))*0.05;
r1 = r2(1:81);

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

% Estima��o



