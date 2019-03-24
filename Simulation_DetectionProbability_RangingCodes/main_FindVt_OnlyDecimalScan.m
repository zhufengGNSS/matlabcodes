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

% % Vt Finding based on Auto-Correlation Results
Vt_GPSL1CA_A = zeros(lenLoop, 2);
Vt_GPSL1Cp_A = zeros(lenLoop, 2);
Vt_GPSL1Cd_A = zeros(lenLoop, 2);
Vt_BDSB1Cp_A = zeros(lenLoop, 2);
Vt_BDSB1Cd_A = zeros(lenLoop, 2);
Vt_GALE1b_A =  zeros(lenLoop, 2);
Vt_GALE1c_A =  zeros(lenLoop, 2);

for idx = 1:lenLoop
    [vt, pfa] = fFindVt_DecimalScan('Auto', 0.01, 1e-10, CN_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, 3.03,0.01);
    Vt_GPSL1CA_A(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Auto', 0.01, 1e-10, CN_dB(idx), 63, CorrOut_GPSL1Cp, 10230, sigma, 3.03,0.01);
    Vt_GPSL1Cp_A(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Auto', 0.01, 1e-10, CN_dB(idx), 63, CorrOut_GPSL1Cd, 10230, sigma, 3.03,0.01);
    Vt_GPSL1Cd_A(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Auto', 0.01, 1e-10, CN_dB(idx), 63, CorrOut_BDSB1Cp, 10230, sigma, 3.03,0.01);
    Vt_BDSB1Cp_A(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Auto', 0.01, 1e-10, CN_dB(idx), 63, CorrOut_BDSB1Cd, 10230, sigma, 3.03,0.01);
    Vt_BDSB1Cd_A(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Auto', 0.01, 1e-10, CN_dB(idx), 50,  CorrOut_GALE1b,  4092, sigma, 3.03,0.01);
    Vt_GALE1b_A(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Auto', 0.01, 1e-10, CN_dB(idx), 50,  CorrOut_GALE1c,  4092, sigma, 3.03,0.01);
    Vt_GALE1c_A(idx,:) = [vt, pfa];
    
    save([path,'Vt_Auto.mat'],...
        'Vt_GPSL1CA_A',...
        'Vt_GPSL1Cp_A',...
        'Vt_GPSL1Cd_A',...
        'Vt_BDSB1Cp_A',...
        'Vt_BDSB1Cd_A',...
        'Vt_GALE1b_A',...
        'Vt_GALE1c_A');
    
    disp(['Complete CN_dB ',num2str(CN_dB(idx))]);
end



% % Vt Finding based on Auto-Correlation Results
Vt_GPSL1CA_C = zeros(lenLoop, 2);
Vt_GPSL1Cp_C = zeros(lenLoop, 2);
Vt_GPSL1Cd_C = zeros(lenLoop, 2);
Vt_BDSB1Cp_C = zeros(lenLoop, 2);
Vt_BDSB1Cd_C = zeros(lenLoop, 2);
Vt_GALE1b_C =  zeros(lenLoop, 2);
Vt_GALE1c_C =  zeros(lenLoop, 2);

for idx = 1:lenLoop
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, 1e-10, CN_dB(idx), 32, CorrOut_GPSL1CA,  1023, sigma, 3.03,0.01);
    Vt_GPSL1CA_C(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, 1e-10, CN_dB(idx), 63, CorrOut_GPSL1Cp, 10230, sigma, 3.03,0.01);
    Vt_GPSL1Cp_C(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, 1e-10, CN_dB(idx), 63, CorrOut_GPSL1Cd, 10230, sigma, 3.03,0.01);
    Vt_GPSL1Cd_C(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, 1e-10, CN_dB(idx), 63, CorrOut_BDSB1Cp, 10230, sigma, 3.03,0.01);
    Vt_BDSB1Cp_C(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, 1e-10, CN_dB(idx), 63, CorrOut_BDSB1Cd, 10230, sigma, 3.03,0.01);
    Vt_BDSB1Cd_C(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, 1e-10, CN_dB(idx), 50,  CorrOut_GALE1b,  4092, sigma, 3.03,0.01);
    Vt_GALE1b_C(idx,:) = [vt, pfa];
    
    [vt, pfa] = fFindVt_DecimalScan('Cross', 0.01, 1e-10, CN_dB(idx), 50,  CorrOut_GALE1c,  4092, sigma, 3.03,0.01);
    Vt_GALE1c_C(idx,:) = [vt, pfa];
    
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

