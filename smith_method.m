%% read file

a = dlmread('conjunto5.txt');
t = a(:,2);
y = a(:,1); %y(t)
y1 = y;
plot(t,y)

%% 
%yy2 = smooth(a(:,2),a(:,1),'sgolay');
yy2 = sgolayfilt(y,2,51);
figure;
plot(a(:,2),yy2);
hold on
plot(t,y);



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

max = a(185,1); % ver tamanho
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
t2 = (max-intcpt)/slope;

tau = t2 - t1;
theta = t1;
kp = max - min;

g1 = tf([kp],[tau,1],'OutputDelay',theta)
[y,t_step] =step(g1);


%% Comparando com entrada ao degrau
plot(y,t);




