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

%%
%2
t1 = 0:T:T1;
t2 = T1 + T:T:T2; %Чтобы оно нормально восприняло строку 21 и смогло простроить последовательность от 0 до Т2 добавляем к началу отсчета второго сигнала T
t = 0:T:T2;
u1 = U1 + (U2-U1)/T1*t1;
u2 = U3 + (U4-U3)/(T2-T1)*(t2-T1);
u = [u1 u2];
figure;
hold on;
plot(t,u,'r-');
stem(t,u,'b--');

%%
%3
N = length(u);
k = (0:N-1).';
W = pi/750;
w = -pi:W:pi;
kw = k*w;
kw = kw*(-1i);
e = exp(kw);
Sp = u*e;
f = Fd*w/(2*pi);
figure;
subplot(2,1,1);
ASp = abs(Sp);
plot(f,ASp);
title('Am Spektr');
xlabel('f, kHz');
ylabel('|A(f)|');
subplot(2,1,2);
PSp = angle(Sp);
plot(f,PSp);
title('Phaze Spektr');
xlabel('f, kHz');
ylabel('arg(A(f))');

%%
%4
td = (-5*T):(T/10):(T2+5*T);
Sv = zeros(1,length(td));
for i= 1:N
    Sv = Sv + u(i).*sinc((td-(i-1).*T)./T);
end
figure;
hold on;
grid on;
plot(td,Sv,'r-');
stem(t,u,'b--');
title('Исходный и восстановленный сигналы');

xlabel('t, ms');
ylabel('S,V');