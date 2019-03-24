%% Pre-Processing

% % Correlation Results Loading
path = 'F:\TemporalDataStorage\';

load([path,'CorrOut_GPSL1CA.mat']);
load([path,'CorrOut_GPSL1C.mat']);
load([path,'CorrOut_BDSB1C.mat']);
load([path,'CorrOut_GALE1.mat']);

%% Vt Finding Loops
% % 
CN_dB = [15; 20; 25; 30; 35; 40; 45];
lenLoop = length(CN_dB);

sigma = 1;  % RMS of noise power

% % Vt Finding based on Cross-Correlation Results
Vt_GPSL1CA_C = zeros(lenLoop, 4);
Vt_GPSL1Cp_C = zeros(lenLoop, 4);
Vt_GPSL1Cd_C = zeros(lenLoop, 4);
Vt_BDSB1Cp_C = zeros(lenLoop, 4);
Vt_BDSB1Cd_C = zeros(lenLoop, 4);
Vt_GALE1b_C =  zeros(lenLoop, 4);
Vt_GALE1c_C =  zeros(lenLoop, 4);

prec = 1e-10;
for idx = 1:lenLoop
    [vt, pfa] = fFindVt_BinarySearch('Cross', 0.01, prec, CN_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, 0, 10);
    Vt_GPSL1CA_C(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, prec/10, CN_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, vt, prec*10);
    Vt_GPSL1CA_C(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Cross', 0.01, prec, CN_dB(idx), 63, CorrOut_GPSL1Cp, 10230, sigma, 0, 10);
    Vt_GPSL1Cp_C(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, prec/10, CN_dB(idx), 63, CorrOut_GPSL1Cp,  10230, sigma, vt, prec*10);
    Vt_GPSL1Cp_C(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Cross', 0.01, prec, CN_dB(idx), 63, CorrOut_GPSL1Cd, 10230, sigma, 0, 10);
    Vt_GPSL1Cd_C(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, prec/10, CN_dB(idx), 63, CorrOut_GPSL1Cd,  10230, sigma, vt, prec*10);
    Vt_GPSL1Cp_C(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Cross', 0.01, prec, CN_dB(idx), 63, CorrOut_BDSB1Cp, 10230, sigma, 0, 10);
    Vt_BDSB1Cp_C(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, prec/10, CN_dB(idx), 63, CorrOut_BDSB1Cp,  10230, sigma, vt, prec*10);
    Vt_GPSL1Cp_C(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Cross', 0.01, prec, CN_dB(idx), 63, CorrOut_BDSB1Cd, 10230, sigma, 0, 10);
    Vt_BDSB1Cd_C(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, prec/10, CN_dB(idx), 63, CorrOut_BDSB1Cd,  10230, sigma, vt, prec*10);
    Vt_BDSB1Cd_C(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Cross', 0.01, prec, CN_dB(idx), 50,  CorrOut_GALE1b,  4092, sigma, 0, 10);
    Vt_GALE1b_C(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, prec/10, CN_dB(idx), 50, CorrOut_GALE1b,  4092, sigma, vt, prec*10);
    Vt_GALE1b_C(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Cross', 0.01, prec, CN_dB(idx), 50,  CorrOut_GALE1c,  4092, sigma, 0, 10);
    Vt_GALE1c_C(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, prec/10, CN_dB(idx), 50, CorrOut_GALE1c,  4092, sigma, vt, prec*10);
    Vt_GALE1c_C(idx,3:4) = [vt, pfa];
    
    save([path,'Vt_Cross.mat'],...
        'Vt_GPSL1CA_C',...
        'Vt_GPSL1Cp_C',...
        'Vt_GPSL1Cd_C',...
        'Vt_BDSB1Cp_C',...
        'Vt_BDSB1Cd_C',...
        'Vt_GALE1b_C',...
        'Vt_GALE1c_C');
    
    disp(['Complete CN_dB ',num2str(CN_dB(idx))]);
end