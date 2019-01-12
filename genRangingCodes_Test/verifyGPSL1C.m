%% Validation Information is following: 
% Copy & Paste from IS-GPS-800D
L1Cp_OctInit24 = [  '05752067'; '70146401'; '32066222'; '72125121';
                    '42323273'; '01650642'; '21303446'; '35504263';
                    '66434311'; '52631623'; '04733076'; '50352603';
                    '32026612'; '07476042'; '22210746'; '30706376';
                    '75764610'; '73202225'; '47227426'; '16064126';
                    '66415734'; '27600270'; '66101627'; '17717055';
                    '47500232'; '52057615'; '76153566'; '22444670';
                    '62330044'; '13674337'; '60635146'; '73527653';
                    '63772350'; '33564215'; '52236055'; '64506521';
                    '73561133'; '12647121'; '16640265'; '11161337';
                    '22055260'; '11546064'; '24765004'; '14042504';
                    '53512265'; '15317006'; '16151224'; '67454561';
                    '47542743'; '65057230'; '77415771'; '75364651';
                    '75664330'; '44600202'; '23211425'; '51504740';
                    '47712554'; '67325233'; '61517015'; '43217554';
                    '52520062'; '77073716'; '56350460';           ];
L1Cp_OctFinal24 = [ '20173742'; '35437154'; '00161056'; '71435437';
                    '15035661'; '32606570'; '03475644'; '11316575';
                    '23047575'; '07355246'; '15210113'; '72643606';
                    '63457333'; '46623624'; '35467322'; '70116567';
                    '62731643'; '14040613'; '07750525'; '37171211';
                    '01302134'; '37672235'; '32201230'; '37437553';
                    '23310544'; '07152415'; '02571041'; '52270664';
                    '61317104'; '43137330'; '20336467'; '40745656';
                    '50272475'; '75604301'; '52550266'; '15334214';
                    '53445703'; '71136024'; '01607455'; '73467421';
                    '54372454'; '11526534'; '16522173'; '74053703';
                    '52211303'; '72655147'; '01212152'; '10410122';
                    '22473073'; '63145220'; '65734110'; '25167435';
                    '17524136'; '47064764'; '14016156'; '11723025';
                    '76760325'; '04724615'; '72504743'; '51215201';
                    '00630473'; '71217605'; '50200707';           ];
L1Cd_OctInit24 = [  '77001425'; '23342754'; '30523404'; '03777635';
                    '10505640'; '42134174'; '00471711'; '32237045';
                    '16004766'; '66234727'; '03755314'; '20604227';
                    '25477233'; '32025443'; '35503400'; '70504407';
                    '26163421'; '52176727'; '72557314'; '62043206';
                    '07151343'; '16027175'; '26267340'; '36272365'; 
                    '67707677'; '07760374'; '73633310'; '30401257';
                    '72606251'; '37370402'; '74255661'; '10171147'; 
                    '12242515'; '17426100'; '75647756'; '71265340'; 
                    '74355073'; '45253014'; '12452274'; '07011213';
                    '35143750'; '26442600'; '67214123'; '62274362';
                    '23371051'; '25121057'; '20362622'; '33050463'; 
                    '65334051'; '65523456'; '53741004'; '66360341'; 
                    '34421651'; '04530741'; '12621031'; '62330452'; 
                    '67510404'; '00726605'; '00200154'; '37533004'; 
                    '73771510'; '44071707'; '34665654';           ];
L1Cd_OctFinal24 = [ '52231646'; '46703351'; '00145161'; '11261273';
                    '71364603'; '55012662'; '30373701'; '07706523';
                    '71741157'; '42347523'; '12746122'; '34634113';
                    '47555063'; '01221116'; '37125437'; '32203664';
                    '62162634'; '35012616'; '00437232'; '32130365';
                    '51515733'; '73662313'; '55416712'; '22550142';
                    '31506062'; '44603344'; '05252052'; '70603616';
                    '51643216'; '30417163'; '20074570'; '26204176';
                    '07105451'; '31062227'; '36516016'; '07641474';
                    '35065520'; '03155010'; '34041736'; '20162561';
                    '01603755'; '40541055'; '64750626'; '72550016';
                    '36130364'; '25236175'; '43732204'; '02316015';
                    '00212370'; '35163655'; '33771603'; '41161255';
                    '76257261'; '33512503'; '16237466'; '24120336';
                    '11103121'; '36467526'; '66444010'; '70455364';
                    '26726105'; '63663333'; '42142704';           ];
            

%% Octal to Binary
% 1. Octal(string) to Decimal(number) by User Defined Function
L1Cp_DecInit24  = zeros(63,1);
L1Cp_DecFinal24 = zeros(63,1);
L1Cd_DecInit24  = zeros(63,1);
L1Cd_DecFinal24 = zeros(63,1);
for lp = 1:63
    L1Cp_DecInit24(lp,:)  = oct2dec(L1Cp_OctInit24 (lp,:));
    L1Cp_DecFinal24(lp,:) = oct2dec(L1Cp_OctFinal24(lp,:));
    L1Cd_DecInit24(lp,:)  = oct2dec(L1Cd_OctInit24 (lp,:));
    L1Cd_DecFinal24(lp,:) = oct2dec(L1Cd_OctFinal24(lp,:));
end

% 2. Decimal(number) to Binary(string) by Matlab Basic Function
L1Cp_BinInit24  = zeros(63,24);
L1Cp_BinFinal24 = zeros(63,24);
L1Cd_BinInit24  = zeros(63,24);
L1Cd_BinFinal24 = zeros(63,24);
for lp1 = 1:63
    temp = dec2bin(L1Cp_DecInit24(lp1,:));
    len = length(temp);
    zeropadd = [];
    if len < 24        
        for lp2 = 1:(24-len)
            zeropadd = [zeropadd '0']; %#ok<AGROW>
        end
    end
    L1Cp_BinInit24(lp1,:) = [zeropadd temp];

    temp = dec2bin(L1Cp_DecFinal24(lp1,:));
    len = length(temp);
    zeropadd = [];
    if len < 24        
        for lp2 = 1:(24-len)
            zeropadd = [zeropadd '0']; %#ok<AGROW>
        end
    end
    L1Cp_BinFinal24(lp1,:) = [zeropadd temp];

    temp = dec2bin(L1Cd_DecInit24(lp1,:));
    len = length(temp);
    zeropadd = [];
    if len < 24
        for lp2 = 1:(24-len)
            zeropadd = [zeropadd '0']; %#ok<AGROW>
        end
    end
    L1Cd_BinInit24(lp1,:) = [zeropadd temp];

    temp = dec2bin(L1Cd_DecFinal24(lp1,:));
    len = length(temp);
    zeropadd = [];
    if len < 24        
        for lp2 = 1:(24-len)
            zeropadd = [zeropadd '0']; %#ok<AGROW>
        end
    end
    L1Cd_BinFinal24(lp1,:) = [zeropadd temp];
end
L1Cp_BinInit24 = char(L1Cp_BinInit24);
L1Cp_BinFinal24 = char(L1Cp_BinFinal24);
L1Cd_BinInit24 = char(L1Cd_BinInit24);
L1Cd_BinFinal24 = char(L1Cd_BinFinal24);

%% L1C Code Generation
colL1Cp = zeros(10230, 63);
colL1Cd = zeros(10230, 63);
for prn = 1:63
    [tp, td] = fgPRN_GPSL1C(prn);
    colL1Cp(:,prn) = tp;
    colL1Cd(:,prn) = td;
end

%% Comparison
bmatL1Cp = zeros(63,2);
bmatL1Cd = zeros(63,2);
for prn = 1:63
    bL1CpI = 0;
    bL1CpF = 0;
    bL1CdI = 0;
    bL1CdF = 0;
    for lp = 1:24
        if colL1Cp(lp,prn) ~= str2double(L1Cp_BinInit24(prn,lp));
            bL1CpI = 1;
        end
        if colL1Cp(10230-24+lp,prn) ~= str2double(L1Cp_BinFinal24(prn,lp));
            bL1CpF = 1;
        end
        
        if colL1Cd(lp,prn) ~= str2double(L1Cd_BinInit24(prn,lp));
            bL1CdI = 1;
        end
        if colL1Cd(10230-24+lp,prn) ~= str2double(L1Cd_BinFinal24(prn,lp));
            bL1CdF = 1;
        end
    end
    
    if bL1CpI
        bmatL1Cp(prn,1) = 1;
    end
    if bL1CpF
        bmatL1Cp(prn,2) = 1;
    end
    
    if bL1CdI
        bmatL1Cd(prn,1) = 1;
    end
    if bL1CdF
        bmatL1Cd(prn,2) = 1;
    end
end

figure;
subplot(211);
stem(bmatL1Cp(:,1));
title('L1C_p Initial 24 Chips Comparison Results (zero means matched)');
xlabel('PRN#');
subplot(212);
stem(bmatL1Cp(:,2));
title('L1C_p Final 24 Chips Comparison Results (zero means matched)');
xlabel('PRN#');

figure;
subplot(211);
stem(bmatL1Cd(:,1));
title('L1C_d Initial 24 Chips Comparison Results (zero means matched)');
xlabel('PRN#');
subplot(212);
stem(bmatL1Cd(:,2));
title('L1C_d Final 24 Chips Comparison Results (zero means matched)');
xlabel('PRN#');

