function [vt, pfa] = fFindVt_BinarySearch(typeCorr, fs, refPfa, refPrcsn, CN0_dB, numPRN, CorrOut, lenCode, sigma, lowVt, highVt)
    targetPRN1 = 1:numPRN;

    vt = lowVt + (highVt - lowVt) / 2;
    
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
        fprintf('Vt=%4.14f, FA=%.14f%%\t',vt,flagFA*100);
        
        % % Right-handed Limit
%         if flagFA > refPfa
%             lowVt = vt;
%             vt = vt + ((highVt - lowVt) / 2);
%             fprintf('Half Upper\n');
%             if (-1*(refPfa - flagFA)) < refPrcsn
%                 vt = lowVt;
%                 pfa = flagFA;
%                 fprintf('Complete!\n');
%                 break;
%             end
%         else
%             highVt = vt;
%             vt = vt - ((highVt - lowVt) / 2);
%             fprintf('Half Lower\n');
%         end
        
        % % Left-handed Limit
        if flagFA < refPfa
            highVt = vt;
            vt = vt - ((highVt - lowVt) / 2);
            fprintf('Half Lower\n');
            if (refPfa - flagFA) < refPrcsn
                vt = highVt;
                pfa = flagFA;
                fprintf('Vt=%4.14f, FA=%.14f%%\t',vt,flagFA*100);
                fprintf('Complete!\n');
                break;
            end
        else
            lowVt = vt;
            vt = vt + ((highVt - lowVt) / 2);
            fprintf('Half Upper\n');
        end

    end
    
end