function colOut = fgPRN_LFSR_Gold(nSRLength,SR1CPS1,SR1CPS2,SR2CPS1,SR2CPS2)
% Gold Code
% Pseudorandom Binary Sequence
% 
% [Inputs]
%   Shift Register Length : nSRLength
%   
% 

    nCodeLength = 2^nSRLength-1;
    
    colIntSR1 = ones(nSRLength,1);
    colIntSR2 = ones(nSRLength,1);
    colOutSR1 = zeros(nCodeLength,1);
    colOutSR2 = zeros(nCodeLength,1);
    colOut = zeros(nCodeLength,1);

    for len=1:nCodeLength
        colOutSR1(len) = colIntSR1(nSRLength);
        temp = xor(colIntSR1(SR1CPS1),colIntSR1(SR1CPS2));
        colIntSR1 = [temp; colIntSR1(1:nSRLength-1)];

        colOutSR2(len) = colIntSR2(nSRLength);
        temp = xor(colIntSR2(SR2CPS1),colIntSR2(SR2CPS2));
        colIntSR2 = [temp; colIntSR2(1:nSRLength-1)];

        colOut(len) = xor(colOutSR1(len), colOutSr2(len));
    end

    colOut = (colOut*2) - 1;
end
