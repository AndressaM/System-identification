%% Smith 2a ordem
s = tf('s');                                                               % define sym

k = input('Valor de k: ');      
theta = input('Valor de theta: ');                                         %delay
t20 = input('Valor de t20: ');
t60 = input('Valor de t60: ');
disp('t20/t60');
proportion = t20/t60;
disp(proportion);

zeta = input('Valor de zeta: ');
t60_tau = input('Valor de t60/tau: ');                                     %t60/tau

tau = t60/t60_tau;

if (zeta > 1)                                                              %superamortecido
    tau1=(tau*zeta + tau*sqrt(zeta^2-1));
    tau2=(tau*zeta - tau*sqrt(zeta^2-1));
    GS2 = exp(-theta*s)*k/((tau1*s+1)*(tau2*s+1));
    
else                                                                       %subamortecido
    GS2 = exp(-theta*s)*k/(tau*s^2 + 2*zeta*tau*s + 1);
end

step(GS2);



    

