%% Pre-Processing

% % Correlation Results Loading
path = 'F:\TemporalDataStorage\';

load([path,'CorrOut_GPSL1CA.mat']);
load([path,'CorrOut_GALE1.mat']);
% load([path,'CorrOut_GPSL1C.mat']);
% load([path,'CorrOut_BDSB1C.mat']);

%% Vt Finding Loops
% % 
CN0_dB = [20; 35; 50];
lenLoop = length(CN0_dB);

sigma = 1;  % RMS of noise power

% % Vt Finding based on Auto-Correlation Results
Vt_GPSL1CA_A = zeros(lenLoop, 4);
Vt_GALE1b_A =  zeros(lenLoop, 4);
Vt_GALE1c_A =  zeros(lenLoop, 4);
% Vt_GPSL1Cp_A = zeros(lenLoop, 4);
% Vt_GPSL1Cd_A = zeros(lenLoop, 4);
% Vt_BDSB1Cp_A = zeros(lenLoop, 4);
% Vt_BDSB1Cd_A = zeros(lenLoop, 4);

fs = 20e6;
prec = 1e-10;
for idx = 1:lenLoop
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, 0, 10000);
    Vt_GPSL1CA_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, vt, prec*10);
    Vt_GPSL1CA_A(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 50,  CorrOut_GALE1b,  4092, sigma, 0, 10000);
    Vt_GALE1b_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 50, CorrOut_GALE1b,  4092, sigma, vt, prec*10);
    Vt_GALE1b_A(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 50,  CorrOut_GALE1c,  4092, sigma, 0, 10000);
    Vt_GALE1c_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 50, CorrOut_GALE1c,  4092, sigma, vt, prec*10);
    Vt_GALE1c_A(idx,3:4) = [vt, pfa];
    
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 63, CorrOut_GPSL1Cp, 10230, sigma, 0, 10000);
%     Vt_GPSL1Cp_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 63, CorrOut_GPSL1Cp,  10230, sigma, vt, prec*10);
%     Vt_GPSL1Cp_A(idx,3:4) = [vt, pfa];
%     
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 63, CorrOut_GPSL1Cd, 10230, sigma, 0, 10000);
%     Vt_GPSL1Cd_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 63, CorrOut_GPSL1Cd,  10230, sigma, vt, prec*10);
%     Vt_GPSL1Cd_A(idx,3:4) = [vt, pfa];
    
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 63, CorrOut_BDSB1Cp, 10230, sigma, 0, 10000);
%     Vt_BDSB1Cp_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 63, CorrOut_BDSB1Cp,  10230, sigma, vt, prec*10);
%     Vt_BDSB1Cp_A(idx,3:4) = [vt, pfa];
%     
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 63, CorrOut_BDSB1Cd, 10230, sigma, 0, 10000);
%     Vt_BDSB1Cd_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 63, CorrOut_BDSB1Cd,  10230, sigma, vt, prec*10);
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
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, 0, 10000);
    Vt_GPSL1CA_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, vt, prec*10);
    Vt_GPSL1CA_A(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 50,  CorrOut_GALE1b,  4092, sigma, 0, 10000);
    Vt_GALE1b_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 50, CorrOut_GALE1b,  4092, sigma, vt, prec*10);
    Vt_GALE1b_A(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 50,  CorrOut_GALE1c,  4092, sigma, 0, 10000);
    Vt_GALE1c_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 50, CorrOut_GALE1c,  4092, sigma, vt, prec*10);
    Vt_GALE1c_A(idx,3:4) = [vt, pfa];
    
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 63, CorrOut_GPSL1Cp, 10230, sigma, 0, 10000);
%     Vt_GPSL1Cp_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 63, CorrOut_GPSL1Cp,  10230, sigma, vt, prec*10);
%     Vt_GPSL1Cp_A(idx,3:4) = [vt, pfa];
%     
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 63, CorrOut_GPSL1Cd, 10230, sigma, 0, 10000);
%     Vt_GPSL1Cd_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 63, CorrOut_GPSL1Cd,  10230, sigma, vt, prec*10);
%     Vt_GPSL1Cp_A(idx,3:4) = [vt, pfa];
    
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 63, CorrOut_BDSB1Cp, 10230, sigma, 0, 10000);
%     Vt_BDSB1Cp_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 63, CorrOut_BDSB1Cp,  10230, sigma, vt, prec*10);
%     Vt_BDSB1Cp_A(idx,3:4) = [vt, pfa];
%     
%     [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CN0_dB(idx), 63, CorrOut_BDSB1Cd, 10230, sigma, 0, 10000);
%     Vt_BDSB1Cd_A(idx,1:2) = [vt, pfa];
%     [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CN0_dB(idx), 63, CorrOut_BDSB1Cd,  10230, sigma, vt, prec*10);
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