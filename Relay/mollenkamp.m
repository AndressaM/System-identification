%%Mollenkamp
syms s

K =input('Valor de K: ');
t15=input('Valor de t15: ');
t45=input('Valor de t45: ');
t75=input('Valor de t75: ');
x=(t45-t15)/(t75-t15);
zeta = (0.085-(5.547*(0.475-x)^2))/(x-0.356);
if zeta < 1
    f2=(0.708)*(2.811)^zeta;
else
    f2=(2.6*zeta)-0.60;
end
wn=f2/(t75-t15);
f3=(0.922)*(1.66^zeta);
theta = t45-(f3/wn);
if(theta<0) theta = 0; end


if (zeta > 1)
    tau1=(zeta+sqrt(zeta^2-1))/wn;
    tau2=(zeta-sqrt(zeta^2-1))/wn;
    GM = exp(-theta*s)*K/((tau1*s+1)*(tau2*s+1));
    
else
    tau = 1/wn;
    GM = exp(-theta*s)*K/(tau*s^2 + 2*zeta*tau*s + 1);
end

%Gs = exp(-theta*s)*wn^2/(s^2 + 2*zeta*wn*s + wn^2);

%
GM2 = GM/s;
gt = ilaplace(GM2);
ht = matlabFunction(gt);
y2 = ht(t);

%plot(t,y2);

% e(t)

e = y1-y2;
e_sum = sum(e.^2);

EQM = e_sum/196;
IAE = sum(abs(e));
ISE = e_sum;
ITAE = sum(t.*e);