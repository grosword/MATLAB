clear;clc;close all;

A = 1.3;
w0 = 0.63;
phi0 = 3.88;
k = 0:(10^5-1);
%x = A*cos(w0*k + phi0); %Гармонический сигнал
load mtlb; x = mtlb/max(abs(mtlb)); %Речевой сигнал
%x = randn(1,length(k)); x = x/max(abs(x)); %Дискретный гауссов шум с
%нулевым средним значением
kv = 256; 
x_q = round(x*kv)/kv;
nq = x - x_q;

figure;
subplot(2,2,1);
plot(nq(1:200));
grid on;
title('Graphic Shuma kvantovania');
xlabel('n');
ylabel('nq(n)');

subplot(2,2,2);
histogram(nq,100);
grid on;
title('Histogramm');
xlabel('Znachenie nq');
ylabel('Kolichecstvo vstrechaniu');

kmax = 100;
[Rx, dk] = xcorr(nq,kmax,'unbiased');
subplot(2,2,3);
plot(dk,Rx);
grid on;
title('AKF shuma');
xlabel('zaderjka');
ylabel('Znachenie AKF');

Lb = 256;
subplot(2,2,4);
pwelch(nq,Lb);

%%
a = [1 -2.6923 3.2301 -1.91882 0.48022];
b = [0.026360 -0.00121 0.038061 -0.001217 0.0263596];
SPM = 9*abs(freqs(1,a)).^2./(10^5);
hspd = dspdata.psd([SPM]);
figure;
plot(hspd);