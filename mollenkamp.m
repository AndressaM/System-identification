%%Mollenkamp
s = tf('s');
K =input('Valor de K: ');
t1=input('Valor de t1: ');
t2=input('Valor de t2: ');
t3=input('Valor de t3: ');
x=(t2-t1)/(t3-t1);
zeta = (0.085-(5.547*(0.475-x)^2))/(x-0.356);
if zeta < 1
    f2=(0.708)*(2.811)^zeta;
else
    f2=(2.6*zeta)-0.60;
end
wn=f2/(t3-t1);
f3=(0.922)*(1.66^zeta);
theta = t2-(f3/wn);

if (zeta > 1)
    tau1=(zeta+sqrt(zeta^2-1))/wn;
    tau2=(zeta-sqrt(zeta^2-1))/wn;
    Gs1 = exp(-theta*s)*K/((tau1*s+1)*(tau2*s+1));
    
else
    tau = 1/wn;
    Gs1 = exp(-theta*s)*K/(tau*s^2 + 2*zeta*tau*s + 1);
end

%Gs = exp(-theta*s)*wn^2/(s^2 + 2*zeta*wn*s + wn^2);



    

