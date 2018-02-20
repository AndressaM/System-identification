%% read file
syms s;

a = dlmread('conjunto2.txt');
t = a(:,2);
y = a(:,1); %y(t)
y1 = y;
%plot(t,y,'r')

%% 
%yy2 = smooth(a(:,2),a(:,1),'sgolay');
yy2 = sgolayfilt(y,2,51);
%figure; 
%plot(a(:,2),yy2);
%hold on
%plot(t,y);



%%  Curve Fitting
[b,S,mu]  = polyfit(t, yy2, 15);
fy = polyval(b,t,S,mu);
y = fy;


%% Calculo deflexao

d1y = gradient(y,t);
d2y = gradient(d1y,t); 

t_infl = interp1(d1y, t, max(d1y));                             % Find ‘t’ At Maximum Of First Derivative
y_infl = interp1(t, y, t_infl);                                 % Find ‘y’ At Maximum Of First Derivative
slope  = interp1(t, d1y, t_infl);                               % Slope Defined Here As Maximum Of First Derivative
intcpt = y_infl - slope*t_infl;                                 % Calculate Intercept
tngt = slope*t + intcpt;                                        % Calculate Tangent Line

%%
[size,aux] = size(y);
max = a(size,1); % ver tamanho
% aqui é a(196,1) , por conta da matriz que y,t;
%estavamos pegando o tempo antes
min = a(1,1);

%% Plot
figure;

plot(t, y1)     % Plot original
hold on 
plot(t, fy)     % plot fitting
plot(t, tngt)   % Plot Linha tangente                                    
hold off
grid
   

legend('y(t)', 'y(t) Fit', 'Tangent')
axis([xlim    min(min(y),intcpt)  ceil(max(y))])


%% Ziegler-Nichols

t1 = -intcpt/slope;
if(t1<0) 
    t1 = 0;
end
t2 = (max-intcpt)/slope;

tau = t2 - t1;
theta = t1;
kp = max - min;

%Gzn = tf([kp],[tau,1],'OutputDelay',theta);
%[y,t_step] =step(Gzn,7);

Gzn = (kp/(tau*s+1))*exp(-theta*s);
Gzn2 = Gzn/s;
gt = ilaplace(Gzn2);
ht = matlabFunction(gt);
y_step = ht(t);
plot(t,y_step)

% e(t)
e = y1-y_step;
e_sum = sum(e.^2);

EQM = e_sum/size;
IAE = sum(abs(e));
ISE = e_sum;
ITAE = sum(t.*e);


%% Comparando com entrada ao degrau
plot(y,t);
    
%% Hagglund

kp = max - min;
t1 = -intcpt/slope;
if(t1<0) 
    t1 = 0;
end
t2 = (max-intcpt)/slope;
theta = t1;
t3 = input('Valor de t3 63,2%:');
tau = t3-t1;

GHAG = (kp/(tau*s+1))*exp(-theta*s);
GHAG2 = GHAG/s;
gt = ilaplace(GHAG2);
ht = matlabFunction(gt);
y_step = ht(t);
plot(t,y_step)

% e(t)
e = y1-y_step;
e_sum = sum(e.^2);

EQM = e_sum/size;
IAE = sum(abs(e));
ISE = e_sum;
ITAE = sum(t.*e);


%% Smith 1st Order

K =input('Valor de K: ');
t1=input('Valor de t1: ');
t2=input('Valor de t2: ');

tau = 1.5*(t2-t1);
theta = t2-tau;
if(theta<0)
    theta=0;
end

GS1 = (kp/(tau*s+1))*exp(-theta*s);
GS12 = GS1/s;
gt = ilaplace(GS12);
ht = matlabFunction(gt);
y_step = ht(t);
plot(t,y_step)

% e(t)
e = y1-y_step;
e_sum = sum(e.^2);

EQM = e_sum/size;
IAE = sum(abs(e));
ISE = e_sum;
ITAE = sum(t.*e);



%% Sundaresan e Krishmawany

K =input('Valor de K: ');
t1=input('Valor de t1: ');
t2=input('Valor de t2: ');

tau = 0.67*(t2-t1);
theta = 1.3*t1-0.29*t2;

GSK = (kp/(tau*s+1))*exp(-theta*s);
GSK2 = GSK/s;
gt = ilaplace(GSK2);
ht = matlabFunction(gt);
y_step = ht(t);
plot(t,y_step)

% e(t)
e = y1-y_step;
e_sum = sum(e.^2);

EQM = e_sum/size;
IAE = sum(abs(e));
ISE = e_sum;
ITAE = sum(t.*e);



%% PLot 

plot(t,y1);
hold on
step(Gzn,0.9);%ZeN
step(GHAG,0.9); %haglund
step(GS1,0.9);%Smith 1
step(GSK,0.9);%SeK
step(GM,0.9); %mollenkamp
step(GS2,0.9);%Smith 2
title('CONJUNTO 1');
legend('Curval Original','Zigler e Nichols','Hägglund','Smith 1º ordem','Sudaresan e Krishnaswamy','MollenKamp','Smith 2º ordem');