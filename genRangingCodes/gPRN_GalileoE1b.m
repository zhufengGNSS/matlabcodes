%% File Load
fp = fopen('E1B_PrimaryCode.txt','r');
E1b_Hex = zeros(50,1023);
E1b_Hex = char(E1b_Hex);
E1b_Dec = zeros(50,1);
E1b_Bin = zeros(50,4092);
E1b_Bin = char(E1b_Bin);

addpath('..\_baseFunctions');
for lp1 = 1:50
    E1b_Hex(lp1,:) = fgetl(fp);
    tempseq = [];
    for lp2 = 1:length(E1b_Hex)
        E1b_Dec = hex2dec(E1b_Hex(lp1,lp2));
        temp = dec2bin(E1b_Dec);
        zeropadd = [];
        if length(temp) < 4
            for lp3 = 1:(4-length(temp))
                zeropadd = [zeropadd '0'];
            end
        end
        tempseq = [tempseq zeropadd temp];
    end
    E1b_Bin(lp1,:) = tempseq;
end
fclose(fp);

colE1b = zeros(4092,50);
for lp1 = 1:50
    for lp2 = 1:4092
        colE1b(lp2,lp1) = str2double(E1b_Bin(lp1,lp2));
    end
end

colE1b = logic2unrz(colE1b);
save CodeSequence_PRN_GALE1b colE1b;