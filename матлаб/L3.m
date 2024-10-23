clear;
close all;
clc;

U1 = 8;
U2 = 8;
U3 = -6;
U4 = 0; 
T1 = 6;
T2 = 9;
Fd = 3; 
T = 1 / Fd;

%%
%1
t1 = 0:T:T1;
t2 = T1+T:T:T2;
t = 0:T:T2;
u1 = U1 + (U2-U1)/T1*t1;
u2 = U3 + (U4-U3)/(T2-T1)*(t2-T1);
u = [u1 u2];
figure;
hold on;
stem(t,u,'b--');
title('Ishodniy signal');
xlabel('t, s');
ylabel('u(t), V');

%% 2
n = 0:27;
ud = fft(u);
figure;
subplot(2,1,1);
stem(n,abs(ud),'r-*');
grid on;
title('Graphic modyla spectralnih otschetov');
xlabel('n');
ylabel('|X(n)|');
subplot(2,1,2);
stem(n,angle(ud),'r-*');
grid on;
title('Graphic phasi spectralnih otschetov');
xlabel('n');
ylabel('arg(X(n))');

%% 3
ud2 = ud;
Nmax = 2;
ud2(Nmax+2:length(ud2)- Nmax) = 0;
uv = ifft(ud2);
figure();
hold on
stem(t,u,'b--');
stem(t,uv,'r--*');
title('Ishodniy i vosstanovlenniy signal');
xlabel('t, s');
ylabel('u(t), V');
E0 = sum(abs(u).^2)
E0v = sum(abs(uv).^2)
E0v/E0*100
figure;
subplot(2,1,1);
stem(n,abs(ud2),'r-*');
grid on;
title('Graphic modyla spectralnih otschetov');
xlabel('n');
ylabel('|X(n)|');
subplot(2,1,2);
stem(n,angle(ud2),'r-*');
grid on;
title('Graphic phasi spectralnih otschetov');
xlabel('n');
ylabel('arg(X(n))')

%% 4
n = 0:55;
u4 = [u zeros(1,length(u))];
ud4 = fft(u4);
figure;
subplot(2,1,1);
stem(n,abs(ud4),'r-*');
grid on;
title('Graphic modyla spectralnih otschetov signala, dopolnennogo nylami');
xlabel('n');
ylabel('|X(n)|');
xlim([0 55]);
subplot(2,1,2);
stem(n,angle(ud4),'r-*');
grid on;
xlim([0 55]);
title('Graphic phasi spectralnih otschetov signala, dopolnennogo nylami');
xlabel('n');
ylabel('arg(X(n))')

%% 5
fN = 6:13;
N = 2.^fN;
for i = 1:8
    x1 = [u zeros(1, N(i) - length(u))];
    D = dftmtx(N(i));
    y = zeros(1,N(i));
    tic
    for k = 1:500
        y = x1*D;
    end
    tn(i) = toc;
end
tn1 = tn./2000;
tteor = 0.9*N.^2*10^(-9);
figure;
semilogy(log2(N),(tn1),'r-*');
hold on;
semilogy(log2(N),tteor,'b--');
xlabel('log2(N)');
ylabel('t,s');
legend('Эксперимент','Теория');
grid on;
%% 6
for i = 1:8

    y = zeros(1,N(i));
    tic
    for k = 1:50000
       y = fft(x1,N(i));
    end
    tn2(i)=toc;
end
tn3 = tn2./350000;
tteor2 = 0.25*N.*log2(N)*10^(-9);
figure;
semilogy(log2(N),tn3,'r-*');
hold on;
semilogy(log2(N),tteor2,'b--');
xlabel('log2(N)');
ylabel('t,s');
legend('Эксперимент','Теория');
grid on;