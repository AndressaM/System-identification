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

%%
theta = 1;
tau = 1;
A = 1;
k = y_inf/(kc*(A-y_inf));
kf = kc*k;

k_linha = kf/(kf+1);

tau_linha = ((theta*tau)/(2*(kf+1)))^0.5; 

zeta_tf = (tau+0.5*theta*(1-kc))/(2*theta*tau*(kc+1))^0.5;


%%
s = tf('s')
kp = 1;
g1 = 1/((s+1)^5);

tf1=g1/(g1+1);

[y_step,t_step]=step(tf1);

[M,I]=max(y_step);

y1 = y_step(I,);

%% yuanna-ciborg

tau = (delta_t*(zeta*sqrt(kf+1)+sqrt(zeta^2*(kf+1)+kf))*sqrt((1-zeta^2)*(kf+1)))/pi;
theta = (2*delta_t*sqrt((1-zeta)^2*(kf+1)))/(pi*(zeta*sqrt(kf+1)+sqrt(zeta^2*(kf+1)+kf)));
zeta_m1=-log((y_inf-y_m)/(y_p1-y_inf))/sqrt(pi^2+(log((y_inf-y_m)/(y_p1-y_inf)))^2)


