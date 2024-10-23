clc;clear;close all;
fstop = 0.9 * 10^3;
f = 0:10:2.5*10^3;
A = f<fstop;
figure;
plot(f,A,'r-');
ylabel('|A(f)|');
title('АЧХ идеального ФНЧ');
xlabel('f,kHz');
grid on;

Fs = 5*10^3;
t = 0:1/Fs:50*10^-3;
u = sin(2*pi*fstop*t)./(2*pi*fstop*t);
u(1) = 1;
figure;
stem(t,u,'r-');
ylabel('u(t)');
title('ИХ идеального ФНЧ');
xlabel('t,s');
grid on;
figure;
plot(t,u,'r-');
ylabel('h(t)');
title('ИХ идеального ФНЧ');
xlabel('t,s');
grid on;