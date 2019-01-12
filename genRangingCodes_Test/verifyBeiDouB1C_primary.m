%% Validation Information is following: 
% Copy & Paste from BDS-SIS-ICD-B1I-1.0
B1Cp_OctInit24 = [  '71676756'; '60334021'; '24562714'; '61011650';
                    '67337730'; '23762642'; '25365366'; '57226722';
                    '72643175'; '00236125'; '12071371'; '61136116';
                    '36261215'; '13607013'; '31010541'; '73163062';
                    '30250537'; '56226421'; '26205736'; '02450570';
                    '66511327'; '06323465'; '10633350'; '10544206';
                    '43714115'; '55641056'; '26572456'; '75123401';
                    '70041254'; '53034467'; '50733517'; '73077145';
                    '55454316'; '37137206'; '45724432'; '55560467';
                    '13467065'; '24245150'; '22265044'; '10003471';
                    '36537736'; '57706617'; '76411007'; '61643153';
                    '50125760'; '66657234'; '01350500'; '43621551';
                    '42435620'; '74327566'; '44553226'; '52231514';
                    '46576047'; '46312270'; '04717127'; '50407031';
                    '10044104'; '36610123'; '73470741'; '24072445';
                    '07765425'; '32242545'; '03210227';          ];
B1Cp_OctLast24 = [  '13053205'; '46604773'; '60007065'; '23616424';
                    '66243127'; '33630334'; '43456307'; '76521063';
                    '52465264'; '76142064'; '60232627'; '05607727';
                    '77737367'; '16031533'; '55416670'; '33076260';
                    '73355574'; '42437243'; '66470710'; '54366756';
                    '23666556'; '74622250'; '16402734'; '54230354';
                    '37167223'; '56136734'; '62211315'; '40615033';
                    '63213062'; '03066540'; '30062510'; '34360276';
                    '45431517'; '47647044'; '33773217'; '77620561';
                    '17327352'; '62223375'; '67665257'; '27515010';
                    '37705710'; '76736116'; '77202566'; '25334277';
                    '70220333'; '22376763'; '31043217'; '20166102';
                    '16423062'; '31245527'; '37160613'; '03414402';
                    '04003162'; '54703562'; '25225202'; '31643432';
                    '27063234'; '40756155'; '24774305'; '51507057';
                    '12225744'; '62104320'; '56250500';          ];

B1Cd_OctInit24 = [  '53773116'; '32235341'; '17633713'; '41551514';
                    '17205134'; '04254545'; '70663435'; '16701045';
                    '32132263'; '25432015'; '31711760'; '25604267';
                    '65705054'; '24700370'; '72405456'; '02621063';
                    '00506754'; '44317266'; '14463723'; '70234110';
                    '62002462'; '52312612'; '34500023'; '77312776';
                    '03712305'; '02501573'; '66632544'; '00447425';
                    '50643132'; '75652754'; '40610704'; '60523643';
                    '30522043'; '06337743'; '41375664'; '20200053';
                    '22017103'; '67327102'; '07154144'; '45367715';
                    '46775773'; '37123271'; '34054132'; '36632600';
                    '43776172'; '13675272'; '53755564'; '60621674';
                    '22415634'; '37363473'; '77262176'; '57132462';
                    '13314107'; '54474504'; '76023074'; '60652454';
                    '31371623'; '52134040'; '41013755'; '20323763';
                    '52445270'; '50735662'; '27571255';          ];
B1Cd_OctLast24 = [  '42711657'; '17306122'; '01145221'; '05307430';
                    '46341377'; '60604443'; '50500234'; '27476454';
                    '70555612'; '43004057'; '07100551'; '15703521';
                    '12615632'; '14267226'; '25330122'; '15741134';
                    '62665617'; '07251312'; '26526763'; '33737311';
                    '34564677'; '30142557'; '52015335'; '56550366';
                    '04531416'; '00717773'; '65070030'; '65742570';
                    '47674377'; '45534064'; '03636755'; '52040645';
                    '36645510'; '54551553'; '26065254'; '03373656';
                    '15754234'; '36032344'; '00456573'; '20772116';
                    '04657766'; '11652043'; '63673657'; '06140620';
                    '42103455'; '71143561'; '07122624'; '32065524';
                    '47205733'; '71732000'; '11057010'; '60447016';
                    '77551540'; '54256322'; '61777241'; '37175533';
                    '00254400'; '51277171'; '57767521'; '60063316';
                    '12771226'; '51142373'; '47160627';          ];

%% Octal to Binary
% 1. Octal(string) to Decimal(number) by User Defined Function
B1Cp_DecInit24 = zeros(63,1);
B1Cp_DecLast24 = zeros(63,1);
B1Cd_DecInit24 = zeros(63,1);
B1Cd_DecLast24 = zeros(63,1);
for lp = 1:63
    B1Cp_DecInit24(lp,:) = oct2dec(B1Cp_OctInit24(lp,:));
    B1Cp_DecLast24(lp,:) = oct2dec(B1Cp_OctLast24(lp,:));
    B1Cd_DecInit24(lp,:) = oct2dec(B1Cd_OctInit24(lp,:));
    B1Cd_DecLast24(lp,:) = oct2dec(B1Cd_OctLast24(lp,:));
end

% 2. Decimal(number) to Binary(string) by Matlab Basic Function
B1Cp_BinInit24 = zeros(63,24);
B1Cp_BinLast24 = zeros(63,24);
B1Cd_BinInit24 = zeros(63,24);
B1Cd_BinLast24 = zeros(63,24);
for lp1 = 1:63
    temp = dec2bin(B1Cp_DecInit24(lp1,:));
    len = length(temp);
    zeropadd = [];
    if len < 24        
        for lp2 = 1:(24-len)
            zeropadd = [zeropadd '0']; %#ok<AGROW>
        end
    end
    B1Cp_BinInit24(lp1,:) = [zeropadd temp];

    temp = dec2bin(B1Cp_DecLast24(lp1,:));
    len = length(temp);
    zeropadd = [];
    if len < 24        
        for lp2 = 1:(24-len)
            zeropadd = [zeropadd '0']; %#ok<AGROW>
        end
    end
    B1Cp_BinLast24(lp1,:) = [zeropadd temp];

    temp = dec2bin(B1Cd_DecInit24(lp1,:));
    len = length(temp);
    zeropadd = [];
    if len < 24
        for lp2 = 1:(24-len)
            zeropadd = [zeropadd '0']; %#ok<AGROW>
        end
    end
    B1Cd_BinInit24(lp1,:) = [zeropadd temp];

    temp = dec2bin(B1Cd_DecLast24(lp1,:));
    len = length(temp);
    zeropadd = [];
    if len < 24        
        for lp2 = 1:(24-len)
            zeropadd = [zeropadd '0']; %#ok<AGROW>
        end
    end
    B1Cd_BinLast24(lp1,:) = [zeropadd temp];
end
B1Cp_BinInit24 = char(B1Cp_BinInit24);
B1Cp_BinLast24 = char(B1Cp_BinLast24);
B1Cd_BinInit24 = char(B1Cd_BinInit24);
B1Cd_BinLast24 = char(B1Cd_BinLast24);

%% B1C Code Generation
colB1Cp = zeros(10230, 63);
colB1Cd = zeros(10230, 63);
for prn = 1:63
    [tp, td] = fgPRN_BeiDouB1C(prn);
    colB1Cp(:,prn) = tp;
    colB1Cd(:,prn) = td;
end

%% Comparison
bmatB1Cp = zeros(63,2);
bmatB1Cd = zeros(63,2);
for prn = 1:63
    bB1CpI = 0;
    bB1CpF = 0;
    bB1CdI = 0;
    bB1CdF = 0;
    for lp = 1:24
        if colB1Cp(lp,prn) ~= str2double(B1Cp_BinInit24(prn,lp));
            bB1CpI = 1;
        end
        if colB1Cp(10230-24+lp,prn) ~= str2double(B1Cp_BinLast24(prn,lp));
            bB1CpF = 1;
        end
        
        if colB1Cd(lp,prn) ~= str2double(B1Cd_BinInit24(prn,lp));
            bB1CdI = 1;
        end
        if colB1Cd(10230-24+lp,prn) ~= str2double(B1Cd_BinLast24(prn,lp));
            bB1CdF = 1;
        end
    end
    
    if bB1CpI
        bmatB1Cp(prn,1) = 1;
    end
    if bB1CpF
        bmatB1Cp(prn,2) = 1;
    end
    
    if bB1CdI
        bmatB1Cd(prn,1) = 1;
    end
    if bB1CdF
        bmatB1Cd(prn,2) = 1;
    end
end

figure;
subplot(211);
stem(bmatB1Cp(:,1));
title('B1C_p Initial 24 Chips Comparison Results (zero means matched)');
xlabel('PRN#');
subplot(212);
stem(bmatB1Cp(:,2));
title('B1C_p Last 24 Chips Comparison Results (zero means matched)');
xlabel('PRN#');

figure;
subplot(211);
stem(bmatB1Cd(:,1));
title('B1C_d Initial 24 Chips Comparison Results (zero means matched)');
xlabel('PRN#');
subplot(212);
stem(bmatB1Cd(:,2));
title('B1C_d Last 24 Chips Comparison Results (zero means matched)');
xlabel('PRN#');

