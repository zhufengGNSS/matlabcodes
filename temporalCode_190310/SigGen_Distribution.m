clear all;
% close all;
clc;

time = 10000; %ms
fs = 2000; %kHz
fc = 1575420000;
CNR = -20;

CA_code = 2.*code_generator(1)-1;
Sampled_CA_code = zeros(1,fs);
Sampled_Carrier_I = zeros(1,fs);
Sampled_Carrier_Q = zeros(1,fs);

%%% IF Signal Generation
for ii=1:fs
    Sampled_CA_code(ii) = 1*CA_code(ceil((rem(ii-1,fs)+1)*1023/fs));
    Sampled_Carrier_I(ii) = 1*cos(1*(2*pi*(fc)*(ii/fs)*0.001));
    Sampled_Carrier_Q(ii) = 1*sin(1*(2*pi*(fc)*(ii/fs)*0.001));
end

Amp = sqrt(2*10^(CNR/10));
Signal = Amp.*Sampled_CA_code.*Sampled_Carrier_I;
%SNR = 10*log10(var(Signal)/var(randn(1,fs)))
SNR = 10*log10(var(Signal)/1)

% tt = var(randn(1,fs));
% Signal = Amp.*Sampled_CA_code.*Sampled_Carrier_I;
% SNR = 10*log10(var(Signal)/tt)
% Signal = Amp.*Sampled_Carrier_I;
% SNR = 10*log10(var(Signal)/tt)
% Signal = Amp.*Sampled_CA_code;
% SNR = 10*log10(var(Signal)/tt)

%%% Correlation Outputs Generation
Corr_I_S = zeros(1,time);
Corr_Q_S = zeros(1,time);
Corr_I_N = zeros(1,time);
Corr_Q_N = zeros(1,time);

Amp_R = 2;
Delay = 0; %8568;
for kk=1:time
    bb_noise_I = randn(1,fs);
    bb_noise_Q = randn(1,fs);
    Corr_I_N(kk) = bb_noise_I*([Sampled_CA_code(1+Delay:fs) Sampled_CA_code(1:Delay)].*Amp_R.*Sampled_Carrier_I)';
    Corr_Q_N(kk) = bb_noise_Q*([Sampled_CA_code(1+Delay:fs) Sampled_CA_code(1:Delay)].*Amp_R.*Sampled_Carrier_Q)';
    bb_signal = Signal+randn(1,fs);
    Corr_I_S(kk) = bb_signal*([Sampled_CA_code(1+Delay:fs) Sampled_CA_code(1:Delay)].*Amp_R.*Sampled_Carrier_I)';
    Corr_Q_S(kk) = bb_signal*([Sampled_CA_code(1+Delay:fs) Sampled_CA_code(1:Delay)].*Amp_R.*Sampled_Carrier_Q)';
end

Norm = sqrt(2*fs);

% for Delay=1:1:fs
%     bb_noise_I = randn(1,fs);
%     bb_noise_Q = randn(1,fs);
%     Corr_I_N(Delay) = bb_noise_I*([Sampled_CA_code(1+Delay:fs) Sampled_CA_code(1:Delay)].*Amp_R.*Sampled_Carrier_I)';
%     Corr_Q_N(Delay) = bb_noise_Q*([Sampled_CA_code(1+Delay:fs) Sampled_CA_code(1:Delay)].*Amp_R.*Sampled_Carrier_Q)';
%     bb_signal = Signal;%+randn(1,fs);
%     Corr_I_S(Delay) = bb_signal*([Sampled_CA_code(1+Delay:fs) Sampled_CA_code(1:Delay)].*Amp_R.*Sampled_Carrier_I)';
%     Corr_Q_S(Delay) = bb_signal*([Sampled_CA_code(1+Delay:fs) Sampled_CA_code(1:Delay)].*Amp_R.*Sampled_Carrier_Q)';
% end
% 
% figure;
% plot(sqrt(Corr_I_N.^2+Corr_Q_N.^2)./Norm,'.-');
% figure;
% plot(sqrt(Corr_I_S.^2+Corr_Q_S.^2)./Norm,'.-');



%%% Pdf of Noise 
Resol_N = 0.005;
% figure;
x = 0:Resol_N:30;
[n xcount] = hist(sqrt(Corr_I_N.^2+Corr_Q_N.^2)./Norm,x); grid on;
plot(xcount,n./(sum(n)/(1/Resol_N))); grid on; hold on;
ylim([0 1]);

z = x;
Pdf_N = z.*exp(-(0.5.*z.^2));
plot(z, Pdf_N,'.-');
ylim([0 1]);



%%% Pdf of Signal
Resol_S = 0.01;
% figure;
x = 0:Resol_S:30;
[n xcount] = hist(sqrt(Corr_I_S.^2+Corr_Q_S.^2)./Norm,x); grid on;
plot(x,n./(sum(n)/(1/Resol_S))); grid on; hold on;
ylim([0 1]);

z = x;
%CN = var(Signal)/var(randn(1,fs))*(fs/2); %*(1023/1023)^2;
CN = var(Signal)/1*(fs/2); %*(1023/1023)^2;
CN_dB = 10*log10(CN)
Pdf_S = z.*exp(-(0.5.*z.^2+CN)).*besseli(0,z.*sqrt(2*CN));
plot(z, Pdf_S,'.-'); 
ylim([0 1]);

% hold on;
% 
% % 아래 임의 추가
% z = x;
% CN = var(Signal)/var(randn(1,fs))*(1023/1023)^2*0.001;
% CN_dB = 10*log10(CN)
% Pdf_S = z.*exp(-(0.5.*z.^2+CN)).*besseli(0,z.*sqrt(2*CN));
% plot(z, Pdf_S,'.-'); 
% ylim([0 1]);
