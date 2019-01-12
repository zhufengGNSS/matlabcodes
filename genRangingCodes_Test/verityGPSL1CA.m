%% Validation Information is following: 
% Copy & Paste from IS-GPS-200H
L1CA_OctInit10 = [  '1440'; '1620'; '1710'; '1744';
                    '1133'; '1455'; '1131'; '1454';
                    '1626'; '1504'; '1642'; '1750';
                    '1764'; '1772'; '1775'; '1776';
                    '1156'; '1467'; '1633'; '1715';
                    '1746'; '1763'; '1063'; '1706';
                    '1743'; '1761'; '1770'; '1774';
                    '1127'; '1453'; '1625'; '1712';
                    '1745'; '1713'; '1134'; '1456';
                    '1713';                         ];

%% Octal to Binary
% 1. Octal(string) to Decimal(number) by User Defined Function
L1CA_DecInit10 = zeros(37,1);
for lp = 1:37
    L1CA_DecInit10(lp,:)  = oct2dec(L1CA_OctInit10 (lp,:));
end

% 2. Decimal(number) to Binary(string) by Matlab Basic Function
L1CA_BinInit10  = zeros(37,10);
for lp1 = 1:37
    temp = dec2bin(L1CA_DecInit10(lp1,:));
    len = length(temp);
    zeropadd = [];
    if len < 10        
        for lp2 = 1:(10-len)
            zeropadd = [zeropadd '0']; %#ok<AGROW>
        end
    end
    L1CA_BinInit10(lp1,:) = [zeropadd temp];
end
L1CA_BinInit10 = char(L1CA_BinInit10);

%% L1 C/A Code Generation
colL1CA = zeros(1023, 37);
for prn = 1:37
    to = fgPRN_GPSL1CA(prn);
    colL1CA(:,prn) = to;
end

%% Comparison
bmatL1CA = zeros(37,1);
for prn = 1:37
    bL1CAI = 0;

    for lp = 1:10
        if colL1CA(lp,prn) ~= str2double(L1CA_BinInit10(prn,lp))
            bL1CAI = 1;
        end
    end
    
    if bL1CAI
        bmatL1CA(prn,:) = 1;
    end
end

figure;
stem(bmatL1CA);
title('L1 C/A Initial 10 Chips Comparison Results (zero means matched)');
xlabel('PRN#');
