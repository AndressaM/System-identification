%% read file

a = dlmread('conjunto1.txt');
plot(a(:,2),a(:,1))

%% 
yy = smooth(a(:,2),a(:,1),'moving');
figure;
plot(a(:,2),yy);
figure;
fig = fit(a(:,2),a(:,1),'poly9')
plot(fig)

%%

max = a(196,2); % ver tamanho

%% 


