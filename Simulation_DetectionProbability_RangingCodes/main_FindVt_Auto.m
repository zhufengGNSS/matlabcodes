%% Pre-Processing

% % Correlation Results Loading
path = 'F:\TemporalDataStorage\';

load([path,'CorrOut_GPSL1CA.mat']);
load([path,'CorrOut_GALE1.mat']);
load([path,'CorrOut_GPSL1C.mat']);
load([path,'CorrOut_BDSB1C.mat']);

%% Common Variables
CN0_dB = [20 35 50];
lenLoop = length(CN0_dB);
CNR_dB = CN0_dB - 60;

sigma = 1;  % RMS of noise power

%% Vt Finding Loops @ Sampling Rate 20 MHz
    fs = 20e6;
    %% Distribution Display @ sampling rate 20 MHz
%     addpath('..\genRangingCodes');
%     load CodeSequence_PRN_GPSL1CA.mat;
%     time = 10000; % [ms]
%     fc = 1575.42e6;
%     
%     SampledCode_GPSL1CA = zeros(fs*1e-3,1);
%     SampledCarr_I = zeros(fs*1e-3,1);
%     SampledCarr_Q = zeros(fs*1e-3,1);
%     
%     for ii=1:(fs*1e-3)
%         SampledCode_GPSL1CA(ii) = 1*colL1CA(ceil((rem(ii-1,fs)+1)*1023/fs),1);
%         SampledCarr_I(ii) = 1*cos(1*(2*pi*(fc)*(ii/fs)*0.001));
%         SampledCarr_Q(ii) = 1*sin(1*(2*pi*(fc)*(ii/fs)*0.001));
%     end
%     
%     Amp = sqrt(2*10.^(CN0_dB/10) * 0.001);
%     Signal_GPSL1CA = Amp.*(SampledCode_GPSL1CA.*SampledCarr_I);
%     SNR = 10*log10(var(Signal_GPSL1CA)/1);
%     
%     Corr_I_Noise = zeros(time,1);
%     Corr_Q_Noise = zeros(time,1);
%     Corr_I_GPSL1CA = zeros(time,3);
%     Corr_Q_GPSL1CA = zeros(time,3);
%     
%     Amp_R = 2;
%     Delay = 0;
%     for kk=1:time
%         bb_noise_I = randn(1,fs*1e-3);
%         bb_noise_Q = randn(1,fs*1e-3);
%         Corr_I_Noise(kk) = bb_noise_I*([SampledCode_GPSL1CA(1+Delay:fs*1e-3); SampledCode_GPSL1CA(1:Delay)].*Amp_R.*SampledCarr_I);
%         Corr_Q_Noise(kk) = bb_noise_Q*([SampledCode_GPSL1CA(1+Delay:fs*1e-3); SampledCode_GPSL1CA(1:Delay)].*Amp_R.*SampledCarr_Q);
%         bb_gpsl1ca  = Signal_GPSL1CA + randn(fs*1e-3,3);
%         Corr_I_GPSL1CA(kk,:) = (transpose(bb_gpsl1ca)*([SampledCode_GPSL1CA(1+Delay:fs*1e-3); SampledCode_GPSL1CA(1:Delay)].*Amp_R.*SampledCarr_I))';
%         Corr_Q_GPSL1CA(kk,:) = (transpose(bb_gpsl1ca)*([SampledCode_GPSL1CA(1+Delay:fs*1e-3); SampledCode_GPSL1CA(1:Delay)].*Amp_R.*SampledCarr_Q))';
%     end
%     
%     %Norm = sqrt(2*fs);
%     Norm = sqrt(2*fs*0.001);
%     
%     figure;
%     Resol =  0.005;
%     rv = 0:Resol:30;
%     [n xcount] = hist(sqrt(Corr_I_Noise.^2 + Corr_Q_Noise.^2)./Norm , rv);
%     plot(xcount, n./(sum(n)/(1/Resol)));
%     grid on;
%     hold on;
    
% % Vt Finding based on Auto-Correlation Results
Vt_GPSL1CA_A = zeros(lenLoop, 4);
Vt_GALE1b_A =  zeros(lenLoop, 4);
Vt_GALE1c_A =  zeros(lenLoop, 4);
% Vt_GPSL1Cp_A = zeros(lenLoop, 4);
% Vt_GPSL1Cd_A = zeros(lenLoop, 4);
% Vt_BDSB1Cp_A = zeros(lenLoop, 4);
% Vt_BDSB1Cd_A = zeros(lenLoop, 4);

prec = 1e-10;
for idx = 1:lenLoop
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, 0, 10000);
    Vt_GPSL1CA_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, vt, prec*10);
    Vt_GPSL1CA_A(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 50,  CorrOut_GALE1b,  4092, sigma, 0, 10000);
    Vt_GALE1b_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 50, CorrOut_GALE1b,  4092, sigma, vt, prec*10);
    Vt_GALE1b_A(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 50,  CorrOut_GALE1c,  4092, sigma, 0, 10000);
    Vt_GALE1c_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 50, CorrOut_GALE1c,  4092, sigma, vt, prec*10);
    Vt_GALE1c_A(idx,3:4) = [vt, pfa];
    
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 63, CorrOut_GPSL1Cp, 10230, sigma, 0, 10000);
%     Vt_GPSL1Cp_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 63, CorrOut_GPSL1Cp,  10230, sigma, vt, prec*10);
%     Vt_GPSL1Cp_A(idx,3:4) = [vt, pfa];
%     
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 63, CorrOut_GPSL1Cd, 10230, sigma, 0, 10000);
%     Vt_GPSL1Cd_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 63, CorrOut_GPSL1Cd,  10230, sigma, vt, prec*10);
%     Vt_GPSL1Cd_A(idx,3:4) = [vt, pfa];
%     
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 63, CorrOut_BDSB1Cp, 10230, sigma, 0, 10000);
%     Vt_BDSB1Cp_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 63, CorrOut_BDSB1Cp,  10230, sigma, vt, prec*10);
%     Vt_BDSB1Cp_A(idx,3:4) = [vt, pfa];
%     
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 63, CorrOut_BDSB1Cd, 10230, sigma, 0, 10000);
%     Vt_BDSB1Cd_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 63, CorrOut_BDSB1Cd,  10230, sigma, vt, prec*10);
%     Vt_BDSB1Cd_A(idx,3:4) = [vt, pfa];
    
    save([path,'Vt_Auto_fs20MHz_gpsCAgalE1.mat'],...
        'Vt_GPSL1CA_A',...
        'Vt_GALE1b_A',...
        'Vt_GALE1c_A');
%         'Vt_GPSL1Cp_A',...
%         'Vt_GPSL1Cd_A',...
%         'Vt_BDSB1Cp_A',...
%         'Vt_BDSB1Cd_A',...
    
    disp(['Complete CN0_dB ',num2str(CN0_dB(idx))]);
end



%% Vt Finding Loops @ Sampling Rate 5 MHz
% % Vt Finding based on Auto-Correlation Results
Vt_GPSL1CA_A = zeros(lenLoop, 4);
Vt_GALE1b_A =  zeros(lenLoop, 4);
Vt_GALE1c_A =  zeros(lenLoop, 4);
% Vt_GPSL1Cp_A = zeros(lenLoop, 4);
% Vt_GPSL1Cd_A = zeros(lenLoop, 4);
% Vt_BDSB1Cp_A = zeros(lenLoop, 4);
% Vt_BDSB1Cd_A = zeros(lenLoop, 4);

fs = 5e6;
prec = 1e-10;
for idx = 1:lenLoop
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, 0, 10000);
    Vt_GPSL1CA_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, vt, prec*10);
    Vt_GPSL1CA_A(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 50,  CorrOut_GALE1b,  4092, sigma, 0, 10000);
    Vt_GALE1b_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 50, CorrOut_GALE1b,  4092, sigma, vt, prec*10);
    Vt_GALE1b_A(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 50,  CorrOut_GALE1c,  4092, sigma, 0, 10000);
    Vt_GALE1c_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 50, CorrOut_GALE1c,  4092, sigma, vt, prec*10);
    Vt_GALE1c_A(idx,3:4) = [vt, pfa];
    
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 63, CorrOut_GPSL1Cp, 10230, sigma, 0, 10000);
%     Vt_GPSL1Cp_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 63, CorrOut_GPSL1Cp,  10230, sigma, vt, prec*10);
%     Vt_GPSL1Cp_A(idx,3:4) = [vt, pfa];
%     
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 63, CorrOut_GPSL1Cd, 10230, sigma, 0, 10000);
%     Vt_GPSL1Cd_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 63, CorrOut_GPSL1Cd,  10230, sigma, vt, prec*10);
%     Vt_GPSL1Cp_A(idx,3:4) = [vt, pfa];
%     
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 63, CorrOut_BDSB1Cp, 10230, sigma, 0, 10000);
%     Vt_BDSB1Cp_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 63, CorrOut_BDSB1Cp,  10230, sigma, vt, prec*10);
%     Vt_BDSB1Cp_A(idx,3:4) = [vt, pfa];
%     
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 63, CorrOut_BDSB1Cd, 10230, sigma, 0, 10000);
%     Vt_BDSB1Cd_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 63, CorrOut_BDSB1Cd,  10230, sigma, vt, prec*10);
%     Vt_BDSB1Cd_A(idx,3:4) = [vt, pfa];
    
    save([path,'Vt_Auto_fs5MHz_gpsCAgalE1.mat'],...
        'Vt_GPSL1CA_A',...
        'Vt_GALE1b_A',...
        'Vt_GALE1c_A');
%         'Vt_GPSL1Cp_A',...
%         'Vt_GPSL1Cd_A',...
%         'Vt_BDSB1Cp_A',...
%         'Vt_BDSB1Cd_A',...
    
    disp(['Complete CN0_dB ',num2str(CN0_dB(idx))]);
end