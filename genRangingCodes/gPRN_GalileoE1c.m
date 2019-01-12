%% File Load
fp = fopen('E1C_PrimaryCode.txt','r');
E1c_Hex = zeros(50,1023);
E1c_Hex = char(E1c_Hex);
E1c_Dec = zeros(50,1);
E1c_Bin = zeros(50,4092);
E1c_Bin = char(E1c_Bin);

addpath('..\_baseFunctions');
for lp1 = 1:50
    E1c_Hex(lp1,:) = fgetl(fp);
    tempseq = [];
    for lp2 = 1:length(E1c_Hex)
        E1c_Dec = hex2dec(E1c_Hex(lp1,lp2));
        temp = dec2bin(E1c_Dec);
        zeropadd = [];
        if length(temp) < 4
            for lp3 = 1:(4-length(temp))
                zeropadd = [zeropadd '0'];
            end
        end
        tempseq = [tempseq zeropadd temp];
    end
    E1c_Bin(lp1,:) = tempseq;
end
fclose(fp);

colE1c = zeros(4092,50);
for lp1 = 1:50
    for lp2 = 1:4092
        colE1c(lp2,lp1) = str2double(E1c_Bin(lp1,lp2));
    end
end

colE1c = logic2unrz(colE1c);
save CodeSequence_PRN_GALE1c colE1c;