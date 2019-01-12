function colOut = fgPRN_LFSR_MLS(nSRLength,n1,n2)
% Maximum Length Sequence (MLS)
% Pseudorandom Binary Sequence
% 
% [Inputs]
%   Shift Register Length : nSRLength
%   
% 

    nCodeLength = 2^nSRLength-1;
    
    colIntSR = ones(nSRLength,1);
    colOut = zeros(nCodeLength,1);
    
    for len=1:nCodeLength
        colOut(len) = colIntSR(nSRLength);
        temp = xor(colIntSR(n1),colIntSR(n2));
        colIntSR = [temp; colIntSR(1:nSRLength-1)];
    end
end
