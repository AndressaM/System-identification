function montaRegressores()
% Processo de 2a ordem

m = input('ordem de u: ');
n = input('ordem de y: ');

%entradas
u = ones(100);
%u = (b - a)*rand(100, 1);

Y = [];
phi = [];

y(1:2) = 0; %Definindo condi��o inicial do sistema
u(1:2) = 0;

y(3:100) = y_gz2(1:98);

% Automatizando os regressores
for i = 3:length(u)
   for j = 1:n
       y_r(j) = y(i-j);
   end
   for k = 1:m
       u_r(k) = u(i-k);
   end
   % y1 = y(i-1);
   % y2 = y(i-2);
   % u1 = u(i-1);
   % u2 = u(i-2);
    Y = [Y; y(i)];
    phi = [phi; -y_r u_r];
end

theta = inv(phi'*phi)*phi'*Y;



y_est(1:2) = 0;

a1 = theta(1);
a2 = theta(2);
b1 = theta(3);
b2 = theta(4);

for t=3:(length(y_gz2)+2)
    y_est(t) = -a1*y_est(t-1) -a2*y_est(t-2) + b1*u(t-1) + b2*u(t-2);
end

y_est = y_est(3:end);

end

