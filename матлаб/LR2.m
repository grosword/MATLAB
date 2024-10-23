clear;
close all;
clc;

U1 = 4;
U2 = 12;
U3 = 4;
U4 = -1; 
T1 = 7;
T2 = 15;
Fd = 5;
T = 1 / Fd;
b = [0.0431 -0.0421 0.075 -0.1 0.022];
a = [1 -3 3.5 -2 0.5];

%% 1
t1 = 0:T:T1;
t2 = T1+T:T:T2;
t = 0:T:T2;
x1 = U1 + (U2-U1)/T1*t1;
x2 = U3 + (U4-U3)/(T2-T1)*(t2-T1);
x = [x1 x2];
figure;
hold on;
plot(t,x,'r-');
stem(t,x,'b--');
xlabel('t, ms');
ylabel('u(t), V');
grid on;
%u1 u2 u3 u4.... 
%0 0 0 0 0 ... 0 
t = 0:T:(T2*2+T);
%% 2
x0 = [x, zeros(1, length(x))];
ypr = filter(b,a,x0);
figure;
stem(t,ypr);
title('Сигнал после дискретного фильтра');
xlabel('t, ms');
ylabel('u(t), V');
grid on;

%% 3
ymaxpryamoi = max(abs(ypr));
xmax = max(abs(x));
maxpryam = max(xmax, ymaxpryamoi)

%% 4
ycan = filter(1,a,x0);
figure;

stem(t,ycan);
title('Сигнал после конического фильтра');
xlabel('t, ms');
ylabel('u(t), V');
ycanonicheskiy = max(abs(ycan))
grid on;
%% 5
states = [];
s = [];
for i = 1:length(x0)
   [ytr(i), s] = filter(b,a,x0(i),s);
   states = [states s];
end
figure;
plot(states');
ymaxtranspon = max(max(abs(states')))
grid on;
title('Vnytrennie signali filtra');
xlabel('Samples');
ylabel('u,V');

%% 6
fvtool(b,a,'magnitude')
fvtool(b,a,'phase')
fvtool(b,a,'grpdelay');
fvtool(b,a,'impulse');
fvtool(b,a,'polezero');

%% 7
[r, p, k] = residuez(b,a);
rab = abs(r)
ran = angle(r)
pab = abs(p)
pan = angle(p)
k