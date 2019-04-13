%% Pre-Processing

% % Correlation Results Loading
path = 'F:\TemporalDataStorage\';

load([path,'CorrOut_ZADD1023_0.mat']);

load([path,'CorrOut_ZADD4092_0_1.mat']);
load([path,'CorrOut_ZADD4092_0_2.mat']);
load([path,'CorrOut_ZADD4092_0_3.mat']);
load([path,'CorrOut_ZADD4092_0_4.mat']);
load([path,'CorrOut_ZADD4092_0_5.mat']);
load([path,'CorrOut_ZADD4092_0_6.mat']);
load([path,'CorrOut_ZADD4092_0_7.mat']);
load([path,'CorrOut_ZADD4092_0_8.mat']);
load([path,'CorrOut_ZADD4092_0_9.mat']);
CorrOut_ZADD4092_0(1,  1: 50) = CorrOut_ZADD4092_0_1;
CorrOut_ZADD4092_0(1, 51:100) = CorrOut_ZADD4092_0_2;
CorrOut_ZADD4092_0(1,101:150) = CorrOut_ZADD4092_0_3;
CorrOut_ZADD4092_0(1,151:200) = CorrOut_ZADD4092_0_4;
CorrOut_ZADD4092_0(1,201:250) = CorrOut_ZADD4092_0_5;
CorrOut_ZADD4092_0(1,251:300) = CorrOut_ZADD4092_0_6;
CorrOut_ZADD4092_0(1,301:400) = CorrOut_ZADD4092_0_7;
CorrOut_ZADD4092_0(1,401:500) = CorrOut_ZADD4092_0_8;
CorrOut_ZADD4092_0(1,501:600) = CorrOut_ZADD4092_0_9;
clear CorrOut_ZADD4092_0_1;
clear CorrOut_ZADD4092_0_2;
clear CorrOut_ZADD4092_0_3;
clear CorrOut_ZADD4092_0_4;
clear CorrOut_ZADD4092_0_5;
clear CorrOut_ZADD4092_0_6;
clear CorrOut_ZADD4092_0_7;
clear CorrOut_ZADD4092_0_8;
clear CorrOut_ZADD4092_0_9;

%% Zadoff-Chu Index
    ZC1023idx = [1 19 20 39 55 59 73 78 97 117 128 136 155 164 175 182 194 214 220 234 238 253 272 274 292];
    for lpPRN = 1:length(ZC1023idx)
        CorrOut_ZC1023_0(lpPRN) = struct('CorrOut',NaN(1023,length(ZC1023idx)),...
            'CorrOut_Norm',NaN(1023,length(ZC1023idx)));%,...
            %'CorrOut_absNorm',NaN(1023,length(ZADD1023Target_b)));
        CorrOut_ZC1023_0(lpPRN).CorrOut = CorrOut_ZADD1023_0(ZC1023idx(lpPRN)).CorrOut(:,ZC1023idx);
        CorrOut_ZC1023_0(lpPRN).CorrOut_Norm = CorrOut_ZADD1023_0(ZC1023idx(lpPRN)).CorrOut(:,ZC1023idx) / 1023;
    end
    for lpPRN = 1:length(ZC1023idx)
        CorrOut_ZC1023_0(lpPRN).CorrOut = CorrOut_ZC1023_0(lpPRN).CorrOut(:,lpPRN:length(ZC1023idx));
        CorrOut_ZC1023_0(lpPRN).CorrOut_Norm = CorrOut_ZC1023_0(lpPRN).CorrOut_Norm(:,lpPRN:length(ZC1023idx));
    end
    
    ZC4092idx = [1, 37, 40, 78, 111, 118, 147, 156, 195, 201, 219, 233, 272, 311, 328, 349, 365,...
                         388, 427, 437, 465, 473, 504, 543, 546, 582, 583];
    for lpPRN = 1:length(ZC4092idx)
        CorrOut_ZC4092_0(lpPRN) = struct('CorrOut',NaN(4092,length(ZC4092idx)),...
            'CorrOut_Norm',NaN(4092,length(ZC4092idx)));%,...
            %'CorrOut_absNorm',NaN(1023,length(ZADD1023Target_b)));
        tmpTarget = ZC4092idx(lpPRN:end)-ZC4092idx(lpPRN)+1;
        CorrOut_ZC4092_0(lpPRN).CorrOut = CorrOut_ZADD4092_0(ZC4092idx(lpPRN)).CorrOut(:,tmpTarget);
        CorrOut_ZC4092_0(lpPRN).CorrOut_Norm = CorrOut_ZADD4092_0(ZC4092idx(lpPRN)).CorrOut(:,tmpTarget) / 4092;
    end
%     for lpPRN = 1:length(ZC4092idx)
%         CorrOut_ZC4092_0(lpPRN).CorrOut = CorrOut_ZC4092_0(lpPRN).CorrOut(:,lpPRN:length(ZC4092idx));
%         CorrOut_ZC4092_0(lpPRN).CorrOut_Norm = CorrOut_ZC4092_0(lpPRN).CorrOut_Norm(:,lpPRN:length(ZC4092idx));
%     end

%% Vt Finding Loops
% % 
CN0_dB = [20 35 50];
lenLoop = length(CN0_dB);
CNR_dB = CN0_dB - 60;

sigma = 1;  % RMS of noise power

% % Vt Finding based on Auto-Correlation Results
Vt_ZC1023_A = zeros(lenLoop, 4);
Vt_ZC4092_A = zeros(lenLoop, 4);

fs = 20e6;
prec = 1e-10;
for idx = 1:lenLoop
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 25, CorrOut_ZC1023_0,  1023, sigma, 0, 10000);
    Vt_ZC1023_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 25, CorrOut_ZC1023_0,  1023, sigma, vt, prec*10);
    Vt_ZC1023_A(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 27,  CorrOut_ZC4092_0,  4092, sigma, 0, 10000);
    Vt_ZC4092_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 27, CorrOut_ZC4092_0,  4092, sigma, vt, prec*10);
    Vt_ZC4092_A(idx,3:4) = [vt, pfa];
    
    save([path,'Vt_Auto_fs20MHz_ZC.mat'],...
        'Vt_ZC1023_A',...
        'Vt_ZC4092_A');
    
    disp(['Complete CN0_dB ',num2str(CN0_dB(idx))]);
end


% % Vt Finding based on Auto-Correlation Results
Vt_ZC1023_A = zeros(lenLoop, 4);
Vt_ZC4092_A = zeros(lenLoop, 4);

fs = 5e6;
prec = 1e-10;
for idx = 1:lenLoop
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 25, CorrOut_ZC1023_0,  1023, sigma, 0, 10000);
    Vt_ZC1023_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 25, CorrOut_ZC1023_0,  1023, sigma, vt, prec*10);
    Vt_ZC1023_A(idx,3:4) = [vt, pfa];
    
    [vt, pfa] = fFindVt_BinarySearch('Auto', fs, 0.01, prec, CNR_dB(idx), 27,  CorrOut_ZC4092_0,  4092, sigma, 0, 10000);
    Vt_ZC4092_A(idx,1:2) = [vt, pfa];
    [vt, pfa] = fFindVt_DecimalScan('Auto', fs, 0.01, prec/10, CNR_dB(idx), 27, CorrOut_ZC4092_0,  4092, sigma, vt, prec*10);
    Vt_ZC4092_A(idx,3:4) = [vt, pfa];
    
    save([path,'Vt_Auto_fs5MHz_ZC.mat'],...
        'Vt_ZC1023_A',...
        'Vt_ZC4092_A');
    
    disp(['Complete CN0_dB ',num2str(CN0_dB(idx))]);
end
