%syms s;
s = tf('s');
%% Método do relé 1

%input arguments

eps_0 = input('eps 0: ');
eps = input('eps: ');

d0 = input('d0: ');
d1 = input('d1: ');
d2 = input('d2: ');

% kp
nptos = 40 ;
tamostra = 0.1;
kont = 0;

nptos1 = nptos/tamostra;
for t=2:nptos1
    if(u(t)~=u(t-1))
        kont = kont+1;
        ch(kont)=t;
    end
end
tu_1 = (ch(6)-ch(5))*tamostra;
tu_2 = (ch(5)-ch(4))*tamostra;
aux1 = ch(3);
aux2 = ch(5);
i=0;
for t=aux1:aux2
    i=i+1;
    yi(i)=y(t);
    ui(i)=u(t);
    ti(i)=i*tamostra;
end
a1 = 0.5*([0 yi]+[yi 0]).*([ti 0] - [0 ti]);
a1 = sum(a1(1,2:length(yi)));
a2 =  0.5*([0 ui]+[ui 0]).*([ti 0] - [0 ti]);
a2 = sum(a2(1,2:length(ui)));
kp = a1/a2;

% Au e Ad
arm = d0;
    for t = aux1:aux2
        if y(t) >= arm 
            arm = y(t);
        end
    end
Au = arm;

arm = d0;
    for t = aux1:aux2
        if y(t) <= arm 
            arm = y(t);
        end
    end
%Ad = arm;
Ad = 2;



% theta1 e tau1
theta_1 = ( log( ( (d1-d0)*kp+eps_0-eps )/(Ad + (d1-d0)*kp) ) );
tau_1 = ( tu_1 /(log((d1+d2*kp*exp(theta_1)-(d1-d0)*kp-eps_0+eps)/((d0+d2)*kp-(eps_0+eps)))) );

% Calculando a função de transferência
%Gp = (kp*exp(-theta_1*s))/(tau_1*s + 1);
num = kp;
den = [tau_1 1];
Gp = tf(num, den, 'InputDelay', theta_1);
step(Gp);

hold on
num = 3;
den = [2 1];
gs = tf(num,den);

%legend('Metodo 1', 'Original');

% b) tu_1 = 1.19; tu_2 = 1.685;  d0 = 0; d1 = -0.5; d2 = 1.5; Ad = 0.9; eps = 0.9; eps_0 = -0.9; kp = 2.9
% c)

%% Método do relé 2 
%input arguments
tu = input('Tu: ');
a = input('a: ');
d = input('d: ');
kp = 1;

ku = 4*d/(pi*a);
% Para gp1

tau_1 = (tu/2*pi)*((ku*kp)^2-1)^0.5;
theta_1 = (tu/2*pi)*(pi - atan(2*pi/tu)*tau_1);


Gp1 = (kp*exp(-theta_1*s))/(tau_1*s + 1);

hold on
step(Gp1);
legend('Metodo 2');

%% Para gp2

tau_2 = (tu/2*pi)*((ku*kp)-1)^0.5;
theta_2 = (tu/2*pi)*(pi - atan(2*pi/tu)*tau_2);

Gp2 = (kp*exp(-theta_2*s))/(tau_2*s + 1)^2;

