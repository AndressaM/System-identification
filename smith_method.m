%% read file

a = dlmread('conjunto1.txt');
t = a(:,2);
y = a(:,1); %y(t)
y1 = y;
plot(t,y)

%% 
%yy = smooth(a(:,2),a(:,1),'moving');
%figure;
%plot(a(:,2),yy);
%figure;
%fig = fit(t,y,'poly9'); % fitted curve
%plot(fig)

%%

max = a(196,2); % ver tamanho

%%  Curve Fitting
[b,S,mu]  = polyfit(t, y, 6);
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
t1 = 
t2 = 


teta = t1;
tau = t2 - t1;
kp = deltaY;




