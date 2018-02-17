%%Mollenkamp
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
teta = t2-(f3/wn);
tal1=(zeta+sqrt(zeta^2-1))/wn;
tal2=(zeta-sqrt(zeta^2-1))/wn;

    

