n=5;
u2(1:n) = 0;
[phi2, Y2] = montaRegressoresLinear(length(u2),n,n,y2,u2);
theta2 = inv(phi2'*phi2)*phi2'*Y2;

%% ordem 1
y2_est(1:1) = 0;
aa1 = -theta2(1);
bb1 = theta2(2);
for t=2:(length(u2))
    y2_est(t) = -aa1*y2_est(t-1)+ bb1*u2(t-1);
end
%% ordem 2
y2_est(1:2) = 0;

aa1 = -theta2(1);
aa2 = -theta2(2);
bb1 = theta2(3);
bb2 = theta2(4);
for t=4:(length(u2))
    
    y2_est(t) = -aa1*y2_est(t-1) -aa2*y2_est(t-2) + bb1*u2(t-1) + bb2*u2(t-2);
end
%% ordem 3
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
%% ordem 4
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

%% ordem 5

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
%% plot

figure

plot(y2);
hold on;
plot(y2_est);
residuo=y2-y2_est;
plot(residuo)
title('Ordem 5')
legend('y','y_e_s_t','residuo')
mean(residuo)


