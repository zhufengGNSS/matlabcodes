function [FA_CorrOut,Pfa,Pd] = fCalculationPd(typeCorr, fs, refVt, CN0_dB, numPRN, CorrOut,lenCode, sigma)
    targetPRN = 1:numPRN;
    
    FA_CorrOut = zeros(numPRN,1);

    CN0 = 10^(CN0_dB/10);
    CN = CN0 * 0.001;
   
    sampleeff = fs/2;
    
    for lpPRN1 = targetPRN
        if strcmp(typeCorr,'Auto')
            targetPRN2 = 1;
        elseif strcmp(typeCorr,'Cross')
            targetPRN2 = (1:numPRN-lpPRN1+1);
        end
        for lpPRN2 = targetPRN2
            FA_temp = zeros(lenCode,1);
            NormCorrOut = abs(CorrOut(lpPRN1).CorrOut_Norm(:,lpPRN2)).^2;
            for lpChip = 1:lenCode
                    sidepeak = CN * sampleeff * NormCorrOut(lpChip,:);
                    nu = sqrt(2*(sidepeak));
                    QM_a = nu / sigma;
                    FA_temp(lpChip,1) = marcumq(QM_a,refVt,1);
            end

            nCntCross = nCntCross + 1;
            if lpPRN1 == 1
                FA_CorrOut(lpPRN1) = FA_CorrOut(lpPRN1) + mean(FA_temp(2:lenCode,1));
            else
                FA_CorrOut(lpPRN1) = FA_CorrOut(lpPRN1) + mean(FA_temp);
            end

        end
    end

    flagFA = mean(FA_CorrOut(:));
    Pfa = flagFA;
    
    nu = sqrt(2*(CN));
    QM_a = nu / sigma;
    Pd = marcumq(QM_a,refVt);
end