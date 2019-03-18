%% Flush previous workspace
% clear all;
close all;
clc;

%% Ranging Code Sequences Load
addpath('..\genRangingCodes');

load CodeSequence_PRN_GPSL1CA.mat;
load CodeSequence_Polyphase_ZadoffChu_1023_0.mat;
%% 

time = 100000; %ms
fs = 10230; %kHz
%fc = 1575420000;
fc = 5420000;
CNR = -20;

%%% IF Signal Generation
% colSampledL1CA = zeros(fs,size(colL1CA,2));
% colSampledPPZC1023 = zeros(fs,size(colPPZC1023_0,2));
colSampledL1CA = zeros(fs,1);
colSampledPPZC1023 = zeros(fs,1);

colSampledCarrieri = zeros(fs,1);
colSampledCarrierq = zeros(fs,1);

idx = 1;
% GPS C/A PRN01ÀÇ ÀÚ±â»ó°ü °á°ú
% [1023;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;-1;-1;-1;-1;63;-1;-1;-65;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;-1;-65;-1;-1;-65;-1;-1;-65;-1;-1;-65;-1;-1;-1;-65;63;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;-1;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;-65;-1;-1;-1;-1;-1;-1;-65;-1;-1;-65;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;-65;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;-65;-1;-1;63;-65;-1;-1;-1;63;-65;-1;-1;63;-1;-1;-1;63;-1;-1;-1;-1;-1;63;-1;-1;-1;-1;-1;-1;-1;63;-1;-65;-1;63;63;63;63;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;-1;63;63;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;63;-1;-1;-1;-1;-65;-1;-1;63;-1;-1;-1;-65;63;-65;-1;63;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;63;-1;-65;-65;-1;-1;-1;-65;-1;-1;-1;-1;-65;-1;-65;-1;-65;-1;-1;63;63;-1;-1;63;-1;-1;63;-1;-1;-1;63;-65;-1;-65;63;-1;-65;-1;-1;63;63;-1;-1;-1;-1;-1;-1;63;63;63;-1;-1;-1;-1;63;-1;-1;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;63;-1;-1;-1;-1;-65;-1;-1;63;-1;-1;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;63;63;-65;-1;-1;-1;-65;63;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-65;-1;-1;-1;-65;-1;-1;-1;-1;-1;-1;63;-1;-1;-1;-1;-1;-1;-1;-65;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;-65;63;-1;-1;63;-1;-1;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;63;-1;-1;63;-1;-1;63;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;-65;-1;63;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;-1;63;63;-65;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;-1;-1;-65;-1;63;-1;-1;-65;-1;-1;-1;-65;-1;63;-1;-1;-1;-65;-1;-1;-1;-1;-1;-65;-1;-1;-65;-1;-1;-1;-1;-1;-1;-1;63;-1;63;63;-1;63;-1;-1;-1;-1;-1;-1;-1;-65;-1;-1;-65;-1;-1;-1;-1;-1;-65;-1;-1;-1;63;-1;-65;-1;-1;-1;-65;-1;-1;63;-1;-65;-1;-1;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;-65;63;63;-1;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;63;-1;-65;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;63;-1;-1;63;-1;-1;63;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;-1;-1;63;-1;-1;63;-65;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-65;-1;-1;-1;-1;-1;-1;-1;63;-1;-1;-1;-1;-1;-1;-65;-1;-1;-1;-65;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;63;-65;-1;-1;-1;-65;63;63;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;-1;-1;63;-1;-1;-65;-1;-1;-1;-1;63;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;-1;-1;63;-1;-1;-1;-1;63;63;63;-1;-1;-1;-1;-1;-1;63;63;-1;-1;-65;-1;63;-65;-1;-65;63;-1;-1;-1;63;-1;-1;63;-1;-1;63;63;-1;-1;-65;-1;-65;-1;-65;-1;-1;-1;-1;-65;-1;-1;-1;-65;-65;-1;63;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;63;-1;-65;63;-65;-1;-1;-1;63;-1;-1;-65;-1;-1;-1;-1;63;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;63;63;-1;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;63;63;63;63;-1;-65;-1;63;-1;-1;-1;-1;-1;-1;-1;63;-1;-1;-1;-1;-1;63;-1;-1;-1;63;-1;-1;-65;63;-1;-1;-1;-65;63;-1;-1;-65;-1;-1;-1;-1;-1;-65;-1;-1;-1;-1;-65;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-65;-1;-65;-1;-1;-65;-1;-1;-1;-1;-1;-1;-65;-1;63;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;-1;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;63;-65;-1;-1;-1;-65;-1;-1;-65;-1;-1;-65;-1;-1;-65;-1;-1;-65;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;63;-1;-65;-1;-1;63;-1;-1;-1;-1;-1;63;-1;-1;-1;-1;-1;-1;-1;-1]
% 10chip ¾î±ß³µÀ»¶§ 63, 19chip ¾î±ß³µÀ»¶§ -65
for lp2 = 1:fs
    colSampledL1CA(lp2) = colL1CA(ceil((rem(lp2-1,fs)+1)*1023/fs),idx);
    colSampledPPZC1023(lp2) = colPPZC1023_0(ceil((rem(lp2-1,fs)+1)*1023/fs),idx);

%     colSampledCarrieri(lp2) = cos(1*(2*pi*(fc)*(lp2/fs)*0.001));
%     colSampledCarrierq(lp2) = sin(1*(2*pi*(fc)*(lp2/fs)*0.001));
    colSampledCarrieri(lp2) = cos(1*(2*pi*(fc)*(lp2/fs)*0.001));
    colSampledCarrierq(lp2) = sin(1*(2*pi*(fc)*(lp2/fs)*0.001));
end

Amp = sqrt(2*10^(CNR/10));

colSignalL1CA = Amp .* colSampledL1CA .* colSampledCarrieri;
colSignalPPZC1023 = Amp .* colSampledPPZC1023 .* (colSampledCarrieri + 1i*colSampledCarrierq);
colSignalPPZC1023 = real(colSignalPPZC1023);
% colSignalPPZC1023 = Amp .* colSampledPPZC1023 .* sqrt(1/2).*(colSampledCarrieri + 1i*colSampledCarrierq);

SNR_L1CA = 10*log10(var(colSignalL1CA)/var(randn(1,fs)))
SNR_PPZC1023 = 10*log10(var(colSignalPPZC1023)/var(randn(1,fs)))


%%% Correlation Outputs Generation
colCorrL1CAi = zeros(time,1);
colCorrL1CAq = zeros(time,1);
colCorrPPZC1023i = zeros(time,1);
colCorrPPZC1023q = zeros(time,1);
colCorrNNNNi = zeros(time,1);
colCorrNNNNq = zeros(time,1);

Amp_R = 2;
 
% Delay = 18;
% [colL1CA(1+Delay:1023,1); colL1CA(1:Delay,1)]' * colL1CA(:,1)
% ttt = ceil((rem([0:1:(fs-1)],fs)+1)*1023/fs);
% Delay = 180;
% [colSampledL1CA(1+Delay:fs); colSampledL1CA(1:Delay)]' * colSampledL1CA

Delay = 90;
for lp=1:time
    tempNoisei = randn(fs,1);
    tempNoiseq = randn(fs,1);
    colCorrNNNNi(lp) =  ([colSampledL1CA(1+Delay:fs); colSampledL1CA(1:Delay)].*Amp_R .* colSampledCarrieri)' * tempNoisei;
    colCorrNNNNq(lp) =  ([colSampledL1CA(1+Delay:fs); colSampledL1CA(1:Delay)].*Amp_R .* colSampledCarrierq)' * tempNoiseq;
    
    tempSignalL1CA = colSignalL1CA + randn(fs,1);
    colCorrL1CAi(lp) = ([colSampledL1CA(1+Delay:fs); colSampledL1CA(1:Delay)].*Amp_R .* colSampledCarrieri)' * tempSignalL1CA;
    colCorrL1CAq(lp) = ([colSampledL1CA(1+Delay:fs); colSampledL1CA(1:Delay)].*Amp_R .* colSampledCarrierq)' * tempSignalL1CA;

    %tempSignalPPZC1023 = colSignalPPZC1023 + (randn(fs,1) + 1i*randn(fs,1));
    tempSignalPPZC1023 = colSignalPPZC1023 + randn(fs,1);
    temp = ([colSampledPPZC1023(1+Delay:fs); colSampledPPZC1023(1:Delay)].*Amp_R .* (colSampledCarrieri + 1i*colSampledCarrierq))' * tempSignalPPZC1023;
    %temp = ([colSampledPPZC1023(1+Delay:fs) colSampledPPZC1023(1:Delay)].*(Amp_R/sqrt(2)) .* (colSampledCarrieri + 1i*colSampledCarrierq))' * tempSignalPPZC1023;
    colCorrPPZC1023i(lp) = real(temp);
    colCorrPPZC1023q(lp) = imag(temp);
%     colCorrPPZC1023i(lp) = tempSignalPPZC1023 * ([colSampledPPZC1023(1+Delay:fs) colSampledPPZC1023(1:Delay)].*Amp_R .* colSampledCarrieri);
%     colCorrPPZC1023q(lp) = tempSignalPPZC1023 * ([colSampledPPZC1023(1+Delay:fs) colSampledPPZC1023(1:Delay)].*Amp_R .* colSampledCarrierq);
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
figure;
x = 0:Resol_N:30;
[n xcount] = hist(sqrt(colCorrNNNNi.^2+colCorrNNNNq.^2)./Norm,x); grid on;
plot(xcount,n./(sum(n)/(1/Resol_N))); grid on; hold on;
ylim([0 1]);

z = x;
Pdf_N = z.*exp(-(0.5.*z.^2));
plot(z, Pdf_N,'.-');
ylim([0 1]);

%%% Pdf of GPS L1 C/A Signal
Resol_S = 0.01;
% figure;
x = 0:Resol_S:30;
[n xcount] = hist(sqrt(colCorrL1CAi.^2+colCorrL1CAq.^2)./Norm,x); grid on;
plot(x,n./(sum(n)/(1/Resol_S))); grid on; hold on;
ylim([0 1]);

z = x;
CN = var(colSignalL1CA)/var(randn(1,fs))*(fs/2); %*(1023/1023)^2;
CN_dB = 10*log10(CN)
Pdf_S = z.*exp(-(0.5.*z.^2+CN)).*besseli(0,z.*sqrt(2*CN));
plot(z, Pdf_S,'.-'); 
ylim([0 1]);

%%% Pdf of Zadoff-Chu 1023 sequences
Resol_S = 0.01;
% figure;
x = 0:Resol_S:30;
[n xcount] = hist(sqrt(colCorrPPZC1023i.^2+colCorrPPZC1023q.^2)./Norm,x); grid on;
plot(x,n./(sum(n)/(1/Resol_S))); grid on; hold on;
ylim([0 1]);

z = x;
CN = var(colSignalPPZC1023)/var(randn(1,fs))*(fs/2); %*(1023/1023)^2;
CN_dB = 10*log10(CN)
Pdf_S = z.*exp(-(0.5.*z.^2+CN)).*besseli(0,z.*sqrt(2*CN));
plot(z, Pdf_S,'.-'); 
ylim([0 1]);

legend nn_s_i_m nn_t_h_e_o_r_y gps_s_i_m gps_t_h_e_o_r_y zado_s_i_m zado_t_h_e_o_r_y;


figure;
plot(sqrt(colCorrL1CAi.^2+colCorrL1CAq.^2),'.')
hold on;
plot(sqrt(colCorrPPZC1023i.^2+colCorrPPZC1023q.^2),'.');

figure;
plot(sqrt(colCorrL1CAi.^2+colCorrL1CAq.^2),'.')
hold on;
plot((colCorrPPZC1023i),'.');