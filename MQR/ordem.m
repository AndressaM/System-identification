function [y2_est,y1_est,m_residuo]=ordem( sistema , n,y1,u1,y2,u2)
%sistema 1 ou 2
%n ordem dos regressores
%y1/u1 saida/entrada do sistema 1
%y2/u2 saida/entrada do sistema 2
if(sistema == 1)

switch n

    case 1
u1(1:n)=0;
[phi, Y] = montaRegressoresLinear(length(u1),n,n,y1,u1);
theta = inv(phi'*phi)*phi'*Y;
y1_est(1:1) = 0;
aaa1 = -theta(1);
bbb1 = theta(2);
for t=4:(length(u1))
    
    y1_est(t) = -aaa1*y1_est(t-1)+ bbb1*u1(t-1);
end
residuo = y1-y1_est;
    case 2
 u1(1:n)=0;
[phi, Y] = montaRegressoresLinear(length(u1),n,n,y1,u1);
theta = inv(phi'*phi)*phi'*Y;
y1_est(1:2) = 0;

aaa1 = -theta(1);
aaa2 = -theta(2);
bbb1 = theta(3);
bbb2 = theta(4);
for t=4:(length(u1))
    
    y1_est(t) = -aaa1*y1_est(t-1) -aaa2*y1_est(t-2) + bbb1*u1(t-1) + bbb2*u1(t-2);
end
residuo = y1-y1_est;
    case 3
 u1(1:n)=0;
[phi, Y] = montaRegressoresLinear(length(u1),n,n,y1,u1);
theta = inv(phi'*phi)*phi'*Y;
y1_est(1:3) = 0;
aaa1 = -theta(1);
aaa2 = -theta(2);
aaa3 = -theta(3);
bbb1 = theta(4);
bbb2 = theta(5);
bbb3 = theta(6);
for t=4:(length(u1))
    
    y1_est(t) = -aaa1*y1_est(t-1) -aaa2*y1_est(t-2) -aaa3*y1_est(t-3) + bbb1*u1(t-1) + bbb2*u1(t-2) + bbb3*u1(t-3);
end
residuo = y1-y1_est;
    case 4
u1(1:n)=0;
[phi, Y] = montaRegressoresLinear(length(u1),n,n,y1,u1);
theta = inv(phi'*phi)*phi'*Y;
y1_est(1:4) = 0;
aaa1 = -theta(1);
aaa2 = -theta(2);
aaa3 = -theta(3);
aaa4 = -theta(4);
bbb1 = theta(5);
bbb2 = theta(6);
bbb3 = theta(7);
bbb4 = theta(8);
for t=5:(length(u1))
    y1_est(t) = -aaa1*y1_est(t-1) -aaa2*y1_est(t-2) -aaa3*y1_est(t-3) -aaa4*y1_est(t-4)+ bbb1*u1(t-1) + bbb2*u1(t-2) + bbb3*u1(t-3)+ bbb4*u1(t-4);
end
residuo = y1-y1_est;
    case 5
u1(1:n)=0;
[phi, Y] = montaRegressoresLinear(length(u1),n,n,y1,u1);
theta = inv(phi'*phi)*phi'*Y;
y1_est(1:5) = 0;
aaa1 = -theta(1);
aaa2 = -theta(2);
aaa3 = -theta(3);
aaa4 = -theta(4);
aaa5 = -theta(5);
bbb1 = theta(6);
bbb2 = theta(7);
bbb3 = theta(8);
bbb4 = theta(9);
bbb5 = theta(10);
for t=6:(length(u1))
    
    y1_est(t) = -aaa1*y1_est(t-1) -aaa2*y1_est(t-2) -aaa3*y1_est(t-3) -aaa4*y1_est(t-4)-aaa5*y1_est(t-5)+bbb1*u1(t-1) + bbb2*u1(t-2) + bbb3*u1(t-3)+ bbb4*u1(t-4)+bbb5*u1(t-5);
end
residuo = y1-y1_est;
end

else
u2(1:n) = 0;
[phi2, Y2] = montaRegressoresLinear(length(u2),n,n,y2,u2);
theta2 = inv(phi2'*phi2)*phi2'*Y2;
    switch n
    case 1
y2_est(1:1) = 0;
aa1 = -theta2(1);
bb1 = theta2(2);
for t=2:(length(u2))
    y2_est(t) = -aa1*y2_est(t-1)+ bb1*u2(t-1);
end
    case 2
y2_est(1:2) = 0;

aa1 = -theta2(1);
aa2 = -theta2(2);
bb1 = theta2(3);
bb2 = theta2(4);
for t=4:(length(u2))
    
    y2_est(t) = -aa1*y2_est(t-1) -aa2*y2_est(t-2) + bb1*u2(t-1) + bb2*u2(t-2);
end
    case 3
y2_est(1:3) = 0;

aa1 = -theta2(1);
aa2 = -theta2(2);
aa3 = -theta2(3);
bb1 = theta2(4);
bb2 = theta2(5);
bb3 = theta2(6);
for t=4:(length(u2))
    
    y2_est(t) = -aa1*y2_est(t-1) -aa2*y2_est(t-2) -aa3*y2_est(t-3) + bb1*u2(t-1) + bb2*u2(t-2) + bb3*u2(t-3);
end
    case 4
y2_est(1:4) = 0;
aa1 = -theta2(1);
aa2 = -theta2(2);
aa3 = -theta2(3);
aa4 = -theta2(4);
bb1 = theta2(5);
bb2 = theta2(6);
bb3 = theta2(7);
bb4 = theta2(8);
for t=5:(length(u2))
    y2_est(t) = -aa1*y2_est(t-1) -aa2*y2_est(t-2) -aa3*y2_est(t-3) -aa4*y2_est(t-4)+ bb1*u2(t-1) + bb2*u2(t-2) + bb3*u2(t-3)+ bb4*u2(t-4);
end
    case 5

y2_est(1:5) = 0;
aa1 = -theta2(1);
aa2 = -theta2(2);
aa3 = -theta2(3);
aa4 = -theta2(4);
aa5 = -theta2(5);
bb1 = theta2(6);
bb2 = theta2(7);
bb3 = theta2(8);
bb4 = theta2(9);
bb5 = theta2(10);
for t=6:(length(u2))
    y2_est(t) = -aa1*y2_est(t-1) -aa2*y2_est(t-2) -aa3*y2_est(t-3) -aa4*y2_est(t-4)-aa5*y2_est(t-5)+bb1*u2(t-1) + bb2*u2(t-2) + bb3*u2(t-3)+ bb4*u2(t-4)+bb5*u2(t-5);
end
residuo = y2-y2_est;

    end
 


end
m_residuo=mean(residuo)

