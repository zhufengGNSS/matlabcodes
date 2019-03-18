function colOut = fgPRN_GPSL1CA(prn)
% Gold Code
% Pseudorandom Binary Sequence
% 
% [Inputs]
%   Shift Register Length : nSRLength
%   
% 
    if prn>37
        error('GPS L1 C/A PRN No. is lower than 38. Please use the other function for expanded C/A code generation.');
    end
    cps = [ 2, 6; 3, 7;
            4, 8; 5, 9;
            1, 9; 2,10;
            1, 8; 2, 9;
            3,10; 2, 3;
            3, 4; 5, 6;
            6, 7; 7, 8;
            8, 9; 9,10;
            1, 4; 2, 5;
            3, 6; 4, 7;
            5, 8; 6, 9;
            1, 3; 4, 6;
            5, 7; 6, 8;
            7, 9; 8,10;
            1, 6; 2, 7;
            3, 8; 4, 9;
            5,10; 4,10;
            1, 7; 2, 8;
            4,10;];

    nSRLength   = 10;
    nCodeLength = 2^nSRLength-1;
    
    colIntSR1 = ones(nSRLength,1);
    colIntSR2 = ones(nSRLength,1);
    colOutSR1 = zeros(nCodeLength,1);
    colOutSR2 = zeros(nCodeLength,1);
    colOut = zeros(nCodeLength,1);

    for len=1:nCodeLength
        colOutSR1(len) = colIntSR1(10);
        temp = xor(colIntSR1(3),colIntSR1(10));
        colIntSR1 = [temp; colIntSR1(1:9)];

        colOutSR2(len) = colIntSR2(10);
        SR2_CPS = xor(colIntSR2(cps(prn,1)), colIntSR2(cps(prn,2)));
        temp = xor(colIntSR2(9),colIntSR2(10));
        temp = xor(colIntSR2(8),temp);
        temp = xor(colIntSR2(6),temp);
        temp = xor(colIntSR2(3),temp);
        temp = xor(colIntSR2(2),temp);
        colIntSR2 = [temp; colIntSR2(1:9)];

        colOut(len) = xor(colOutSR1(len), SR2_CPS);
    end
end
