clear all;
close all;
clc;

Nzc = 1023; % 1, 3, 11, 31, 33, 93, 341, 1023
% u1 = 1;
% u2 = 373;
% u3 = 745;
% u4 = 1117;

u1 = 1;
u2 = 93*1+1;
u3 = 93*3+1;
u4 = 93*4+1;
u5 = 93*5+1;
u6 = 93*6+1;
u7 = 93*7+1;
u8 = 93*8+1;
u9 = 93*9+1;
u10 = 93*10+1;

% u1 = 1;
% u2 = 31*1+1;
% u3 = 31*3+1;
% u4 = 31*4+1;
% u5 = 31*7+1;
% u6 = 31*9+1;
% u7 = 31*10+1;
% u8 = 31*12+1;
% u9 = 31*13+1;
% u10 = 31*15+1;

c = mod(Nzc,2);
q1 = 0;
q2 = 0;
q3 = 0;
q4 = 0;
q5 = 0;
q6 = 0;
q7 = 0;
q8 = 0;
q9 = 0;
q10 = 0;


gcd(Nzc,u1)
gcd(Nzc,u2)
gcd(Nzc,u3)
gcd(Nzc,u4)
gcd(Nzc,u5)
gcd(Nzc,u6)
gcd(Nzc,u7)
gcd(Nzc,u8)
gcd(Nzc,u9)
gcd(Nzc,u10)

gcd(Nzc,u2-u1)
gcd(Nzc,u3-u1)
gcd(Nzc,u4-u1)
gcd(Nzc,u5-u1)
gcd(Nzc,u6-u1)
gcd(Nzc,u7-u1)
gcd(Nzc,u8-u1)
gcd(Nzc,u9-u1)
gcd(Nzc,u10-u1)

for n=0:Nzc-1
    x1(1,n+1) = exp(-1j*pi*u1*n*(n+c+2*q1)/Nzc);
    x2(1,n+1) = exp(-1j*pi*u2*n*(n+c+2*q2)/Nzc);
    x3(1,n+1) = exp(-1j*pi*u3*n*(n+c+2*q3)/Nzc);
    x4(1,n+1) = exp(-1j*pi*u4*n*(n+c+2*q4)/Nzc);    
    x5(1,n+1) = exp(-1j*pi*u5*n*(n+c+2*q5)/Nzc);    
    x6(1,n+1) = exp(-1j*pi*u6*n*(n+c+2*q6)/Nzc);    
    x7(1,n+1) = exp(-1j*pi*u7*n*(n+c+2*q7)/Nzc);    
    x8(1,n+1) = exp(-1j*pi*u8*n*(n+c+2*q8)/Nzc);    
    x9(1,n+1) = exp(-1j*pi*u9*n*(n+c+2*q9)/Nzc);    
    x10(1,n+1) = exp(-1j*pi*u10*n*(n+c+2*q10)/Nzc);    
end

X1 = [x1 x1];
X2 = [x2 x2];
X3 = [x3 x3];
X4 = [x4 x4];
X5 = [x5 x5];
X6 = [x6 x6];
X7 = [x7 x7];
X8 = [x8 x8];
X9 = [x9 x9];
X10 = [x10 x10];


for dd=0:Nzc-1
    AutoCorr1(dd+1,1) = X1(1,1:Nzc)*X1(1,1+dd:Nzc+dd)';
    AutoCorr2(dd+1,1) = X2(1,1:Nzc)*X2(1,1+dd:Nzc+dd)';
    AutoCorr3(dd+1,1) = X3(1,1:Nzc)*X3(1,1+dd:Nzc+dd)';
    AutoCorr4(dd+1,1) = X4(1,1:Nzc)*X4(1,1+dd:Nzc+dd)';
    AutoCorr5(dd+1,1) = X5(1,1:Nzc)*X5(1,1+dd:Nzc+dd)';
    AutoCorr6(dd+1,1) = X6(1,1:Nzc)*X6(1,1+dd:Nzc+dd)';
    AutoCorr7(dd+1,1) = X7(1,1:Nzc)*X7(1,1+dd:Nzc+dd)';
    AutoCorr8(dd+1,1) = X8(1,1:Nzc)*X8(1,1+dd:Nzc+dd)';
    AutoCorr9(dd+1,1) = X9(1,1:Nzc)*X9(1,1+dd:Nzc+dd)';
    AutoCorr10(dd+1,1) = X10(1,1:Nzc)*X10(1,1+dd:Nzc+dd)';

    CrossCorr1(dd+1,1) = X1(1,1:Nzc)*X2(1,1+dd:Nzc+dd)';
    CrossCorr2(dd+1,1) = X1(1,1:Nzc)*X3(1,1+dd:Nzc+dd)';
    CrossCorr3(dd+1,1) = X1(1,1:Nzc)*X4(1,1+dd:Nzc+dd)';
    CrossCorr4(dd+1,1) = X1(1,1:Nzc)*X5(1,1+dd:Nzc+dd)';
    CrossCorr5(dd+1,1) = X1(1,1:Nzc)*X6(1,1+dd:Nzc+dd)';
    CrossCorr6(dd+1,1) = X1(1,1:Nzc)*X7(1,1+dd:Nzc+dd)';
    CrossCorr7(dd+1,1) = X1(1,1:Nzc)*X8(1,1+dd:Nzc+dd)';
    CrossCorr8(dd+1,1) = X1(1,1:Nzc)*X9(1,1+dd:Nzc+dd)';
    CrossCorr9(dd+1,1) = X1(1,1:Nzc)*X10(1,1+dd:Nzc+dd)';
end

figure;
plot(abs(AutoCorr1),'.-'); grid on;
figure;
plot(abs(AutoCorr2),'.-'); grid on;
figure;
plot(abs(AutoCorr3),'.-'); grid on;
figure;
plot(abs(AutoCorr4),'.-'); grid on;
figure;
plot(abs(AutoCorr5),'.-'); grid on;
figure;
plot(abs(AutoCorr6),'.-'); grid on;
figure;
plot(abs(AutoCorr7),'.-'); grid on;
figure;
plot(abs(AutoCorr8),'.-'); grid on;
figure;
plot(abs(AutoCorr9),'.-'); grid on;
figure;
plot(abs(AutoCorr10),'.-'); grid on;

figure;
plot(abs(CrossCorr1),'.-'); grid on;
figure;
plot(abs(CrossCorr2),'.-'); grid on;
figure;
plot(abs(CrossCorr3),'.-'); grid on;
figure;
plot(abs(CrossCorr4),'.-'); grid on;
figure;
plot(abs(CrossCorr5),'.-'); grid on;
figure;
plot(abs(CrossCorr6),'.-'); grid on;
figure;
plot(abs(CrossCorr7),'.-'); grid on;
figure;
plot(abs(CrossCorr8),'.-'); grid on;
figure;
plot(abs(CrossCorr9),'.-'); grid on;

% X = X1(101:Nzc+100) + X2(202:Nzc+201) + X3(303:Nzc+302) + X4(404:Nzc+403);
% X = X1(101:Nzc+100) + X2(194:Nzc+193) + X3(303:Nzc+302) + X4(404:Nzc+403);
X = X1(101:Nzc+100) + X2(194:Nzc+193) + X3(287:Nzc+286) + X4(404:Nzc+403);

% X = X1(101:Nzc+100) + X2(202:Nzc+201) + X3(303:Nzc+302) + X4(404:Nzc+403) +...
%     X5(501:Nzc+500) + X6(602:Nzc+601) + X7(703:Nzc+702) + X8(804:Nzc+803) +...
%     X9(901:Nzc+900) + X10(1002:Nzc+1001);

for dd=0:Nzc-1
    Acq1(dd+1,1) = X(1,1:Nzc)*X1(1,1+dd:Nzc+dd)';
    Acq2(dd+1,1) = X(1,1:Nzc)*X2(1,1+dd:Nzc+dd)';
    Acq3(dd+1,1) = X(1,1:Nzc)*X3(1,1+dd:Nzc+dd)';
    Acq4(dd+1,1) = X(1,1:Nzc)*X4(1,1+dd:Nzc+dd)';
%     Acq5(dd+1,1) = X(1,1:Nzc)*X5(1,1+dd:Nzc+dd)';
%     Acq6(dd+1,1) = X(1,1:Nzc)*X6(1,1+dd:Nzc+dd)';
%     Acq7(dd+1,1) = X(1,1:Nzc)*X7(1,1+dd:Nzc+dd)';
%     Acq8(dd+1,1) = X(1,1:Nzc)*X8(1,1+dd:Nzc+dd)';
%     Acq9(dd+1,1) = X(1,1:Nzc)*X9(1,1+dd:Nzc+dd)';
%     Acq10(dd+1,1) = X(1,1:Nzc)*X10(1,1+dd:Nzc+dd)';
end

figure;
plot(abs(Acq1),'.-'); grid on;
figure;
plot(abs(Acq2),'.-'); grid on;
figure;
plot(abs(Acq3),'.-'); grid on;
figure;
plot(abs(Acq4),'.-'); grid on;
figure;
plot(abs(Acq5),'.-'); grid on;
figure;
plot(abs(Acq6),'.-'); grid on;
figure;
plot(abs(Acq7),'.-'); grid on;
figure;
plot(abs(Acq8),'.-'); grid on;
figure;
plot(abs(Acq9),'.-'); grid on;
figure;
plot(abs(Acq10),'.-'); grid on;


