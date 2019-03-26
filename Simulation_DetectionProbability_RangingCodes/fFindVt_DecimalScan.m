function [vt, pfa] = fFindVt_DecimalScan (typeCorr, fs, refPfa, refPrcsn, CN0_dB, numPRN, CorrOut, lenCode, sigma, initVt, initPoint)
    bWhileEnd = 0;
    Pointer = initPoint;
    cntPointer = 1;

    targetPRN1 = 1:numPRN;

    vt = initVt; 
    
    CN0 = 10^(CN0_dB/10);
    CN = CN0 * 0.001;
    
    sampleeff = fs/2; % it also be sampling rate.

    while(1)
        FA_CorrOut_Auto = zeros(numPRN,1);
        for lpPRN1 = targetPRN1
            if strcmp(typeCorr,'Auto')
                targetPRN2 = 1;
            elseif strcmp(typeCorr,'Cross')
                targetPRN2 = (1:numPRN-lpPRN1+1);
            end

            nCntCross = 0;
            for lpPRN2 = targetPRN2
                FA_temp = zeros(lenCode,1);
                NormCorrOut = abs(CorrOut(lpPRN1).CorrOut_Norm(:,lpPRN2)).^2;
                for lpChip = 1:lenCode
                    sidepeak = CN * sampleeff * NormCorrOut(lpChip,:);
                    nu = sqrt(2*(sidepeak));
                    QM_a = nu / sigma;
                    FA_temp(lpChip,1) = marcumq(QM_a,vt,1);
                end
                
                nCntCross = nCntCross + 1;
                if lpPRN2 == 1
                    FA_CorrOut_Auto(lpPRN1) = FA_CorrOut_Auto(lpPRN1) + mean(FA_temp(2:lenCode,1));
                else
                    FA_CorrOut_Auto(lpPRN1) = FA_CorrOut_Auto(lpPRN1) + mean(FA_temp);
                end
            end
            FA_CorrOut_Auto(lpPRN1) = FA_CorrOut_Auto(lpPRN1) / nCntCross;
        end
        
        flagFA = mean(FA_CorrOut_Auto(:,1));
        fprintf('Vt=%.14f, FA=%.14f%%\t',vt,flagFA*100);
        
        if bWhileEnd == 1
            fprintf('Verifying Vt. function return\n');
            pfa = flagFA;
            break;
        end
        
        % % Right-handed Limit
%         if flagFA > refPfa
%             vt = vt + Pointer;
%             cntPointer = cntPointer + 1;
%             fprintf('Vt+Pointer\n');
%         else
%             vt = vt - Pointer;
%             Pointer = Pointer * 0.1;
%             cntPointer = 0;
%             if Pointer < refPrcsn
%                 bWhileEnd = 1;
%                 fprintf('Complete!\n');
%             else
%                 vt = vt + Pointer;
%                 cntPointer = cntPointer + 1;
%                 fprintf('Vt-Pointer, Pointer/10 than Vt+Pointer\n');
%             end
%         end
        
        % % Left-handed Limit
        if flagFA < refPfa
            vt = vt - Pointer;
            cntPointer = cntPointer + 1;
            fprintf('Vt-Pointer\n');
        else
            vt = vt + Pointer;
            Pointer = Pointer * 0.1;
            cntPointer = 0;
            if Pointer < refPrcsn
                bWhileEnd = 1;
                fprintf('Complete!\n');
            else
                vt = vt - Pointer;
                cntPointer = cntPointer + 1;
                fprintf('Vt+Pointer, Pointer/10 than Vt-Pointer\n');
            end
        end

    end
    
end