%% Pre-Processing

% % Correlation Results Loading
path = 'D:\TemporalDataStorage\';

load([path,'CorrOut_GPSL1CA.mat']);
load([path,'CorrOut_GALE1.mat']);

%%
refVtCN0_dB = [20 35 50];
% refVtCN0_dB = 50;
lenLoop1 = length(refVtCN0_dB);

sigma = 1;  % RMS of noise power

fs = 20e6;
% load([path,'Vt_Auto_fs20MHz_gpsCAgalE1.mat']);
% load([path,'Vt_Auto_fs20MHz_ZC.mat']);
for lpRefVtCN0 = 1:lenLoop1
    CN0_dB = [20 25 30 35 40 45 50];
    CN0_dB = CN0_dB-60;
    lenLoop2 = length(CN0_dB);
    for lpCN0 = 1:lenLoop2
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_GPSL1CA_A(lpRefVtCN0,3), CN0_dB(lpCN0), 32, CorrOut_GPSL1CA, 1023, sigma)
        CN0_dB(lpCN0)
    end
end

load([path,'Vt_Auto_fs5MHz_gpsCAgalE1.mat']);
load([path,'Vt_Auto_fs5MHz_ZC.mat']);











