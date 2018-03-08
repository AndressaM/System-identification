s = tf('s');

%% First

kc = 1;

g1 = 1/((s+1)^5);

tf1 = g1*kc/(g1*kc+1);

[y_step, t_step] = step(tf1);

%%

%plot(t_step, y_step)

[y_p1,M] = max(y_step);

y_length = length(y_step);

y_inf = y_step(y_length); 

y_desc = y_step(M:y_length);

[y_m,M2] = min(y_desc);

y_length2 = length(y_desc);

y_desc2 = y_desc(M2:y_length2);

y_p2 = max(y_desc2);

%% yuanna-ciborg

kc= 1;
A=1;
k = y_inf/(kc*(A-y_inf));
kf = kc*k;
delta_t = 5.41;

zeta_m1=-log((y_inf-y_m)/(y_p1-y_inf))/sqrt(pi^2+(log((y_inf-y_m)/(y_p1-y_inf)))^2)
zeta_m2=-log((y_p2-y_inf)/(y_p1-y_inf))/sqrt(4*pi^2+(log((y_p2-y_inf)/(y_p1-y_inf)))^2);
zeta_m = (zeta_m1+zeta_m2)/2;

theta_m = (2*delta_t*sqrt((1-zeta_m^2)*(kf+1)))/pi*(zeta_m*sqrt(kf+1)+sqrt(zeta_m^2*(kf+1)+kf));
tau_m = (delta_t*(zeta_m*sqrt(kf+1)+sqrt(zeta_m^2*(kf+1)+kf))*sqrt((1-zeta_m^2)*(kf+1)))/pi;

k_linha = kf/(kf+1);

tau = ((theta_m*tau_m)/(2*(kf+1)))^0.5; 

zeta =(tau_m+0.5*theta_m*(1-kc))/(2*theta_m*tau_m*(kc+1))^0.5;

tf2 = (k_linha*(1-0.5*theta_m*s))/(tau^2*s^2+2*zeta*tau*s+1);
step(tf2)

%%

kc = 1;
theta = 1;
tau = 1;
A = 1;







