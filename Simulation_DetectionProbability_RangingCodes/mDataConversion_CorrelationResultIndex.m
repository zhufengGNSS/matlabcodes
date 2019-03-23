path = 'D:\TemporalDataStorage\';

% GPS L1 C/A
load([path,'CorrOut_GPSL1CA.mat']);

TEMP = CorrOut_GPSL1CA;
for lp1 = 1:length(CorrOut_GPSL1CA)
    
    TEMP(lp1).CorrOut = CorrOut_GPSL1CA(lp1).CorrOut(:,lp1:end);
    TEMP(lp1).CorrOut_Norm = CorrOut_GPSL1CA(lp1).CorrOut_Norm(:,lp1:end);
end

CorrOut_GPSL1CA = TEMP;
save([path,'CorrOut_GPSL1CA.mat'],'CorrOut_GPSL1CA');

% GPS L1Cd
load([path,'CorrOut_GPSL1C.mat']);

TEMP = CorrOut_GPSL1Cd;
for lp1 = 1:length(CorrOut_GPSL1Cd)
    
    TEMP(lp1).CorrOut = CorrOut_GPSL1Cd(lp1).CorrOut(:,lp1:end);
    TEMP(lp1).CorrOut_Norm = CorrOut_GPSL1Cd(lp1).CorrOut_Norm(:,lp1:end);
end

CorrOut_GPSL1Cd = TEMP;

TEMP = CorrOut_GPSL1Cp;
for lp1 = 1:length(CorrOut_GPSL1Cp)
    
    TEMP(lp1).CorrOut = CorrOut_GPSL1Cp(lp1).CorrOut(:,lp1:end);
    TEMP(lp1).CorrOut_Norm = CorrOut_GPSL1Cp(lp1).CorrOut_Norm(:,lp1:end);
end

CorrOut_GPSL1Cp = TEMP;
save([path,'CorrOut_GPSL1C.mat'],'CorrOut_GPSL1Cd','CorrOut_GPSL1Cp');

% BeiDou B1C
load([path,'CorrOut_BDSB1C.mat']);

TEMP = CorrOut_BDSB1Cd;
for lp1 = 1:length(CorrOut_BDSB1Cd)
    
    TEMP(lp1).CorrOut = CorrOut_BDSB1Cd(lp1).CorrOut(:,lp1:end);
    TEMP(lp1).CorrOut_Norm = CorrOut_BDSB1Cd(lp1).CorrOut_Norm(:,lp1:end);
end

CorrOut_BDSB1Cd = TEMP;

TEMP = CorrOut_BDSB1Cp;
for lp1 = 1:length(CorrOut_BDSB1Cp)
    
    TEMP(lp1).CorrOut = CorrOut_BDSB1Cp(lp1).CorrOut(:,lp1:end);
    TEMP(lp1).CorrOut_Norm = CorrOut_BDSB1Cp(lp1).CorrOut_Norm(:,lp1:end);
end

CorrOut_BDSB1Cp = TEMP;
save([path,'CorrOut_BDSB1C.mat'],'CorrOut_BDSB1Cd','CorrOut_BDSB1Cp');

% Galileo E1
load([path,'CorrOut_GALE1b.mat']);
load([path,'CorrOut_GALE1c.mat']);

TEMP = CorrOut_GALE1b;
for lp1 = 1:length(CorrOut_GALE1b)
    
    TEMP(lp1).CorrOut = CorrOut_GALE1b(lp1).CorrOut(:,lp1:end);
    TEMP(lp1).CorrOut_Norm = CorrOut_GALE1b(lp1).CorrOut_Norm(:,lp1:end);
end

CorrOut_GALE1b = TEMP;

TEMP = CorrOut_GALE1c;
for lp1 = 1:length(CorrOut_GALE1c)
    
    TEMP(lp1).CorrOut = CorrOut_GALE1c(lp1).CorrOut(:,lp1:end);
    TEMP(lp1).CorrOut_Norm = CorrOut_GALE1c(lp1).CorrOut_Norm(:,lp1:end);
end

CorrOut_GALE1c = TEMP;
save([path,'CorrOut_GALE1.mat'],'CorrOut_GALE1b','CorrOut_GALE1c');



