function [vt, pfa] = fFindVt_BinarySearch(Type, pfa_target, Scaler_prec, CN_dB, nNumPRN, CorrOut, nLenCode, sigma, vt_low, vt_high)
    targetPRN1 = 1:nNumPRN;
    
    if Type == 'Auto'       
        targetPRN2 = 1;
    elseif Type == 'Cross'  
        targetPRN2 = 1:nNumPRN;
    end
    
    vt = vt_low + (vt_high - vt_low) / 2;
    
    FA_CorrOut_Auto = zeros(nNumPRN,1);
    
    while(1)
        for lpPRN1 = targetPRN1
            for lpPRN2 = targetPRN2
                FA_temp = zeros(nLenCode,1);
                for lpChip = 1:nLenCode
                    CN = 10^(CN_dB/10) * 0.001 * abs(CorrOut(lpPRN1).CorrOut_Norm(lpChip,lpPRN2))^2;
                    nu = sqrt(2*(CN));
                    QM_a = nu / sigma;
                    FA_temp(lpChip,1) = marcumq(QM_a,vt,1);
                end
                
                if lpPRN2 == 1
                    FA_CorrOut_Auto(lpPRN1) = mean(FA_temp(2:nLenCode,1));
                else
                    FA_CorrOut_Auto(lpPRN1) = mean(FA_temp);
                end
            end
        end
        
        flagFA = mean(FA_CorrOut_Auto(:,1));
        fprintf('Vt=%.14f, FA=%.14f%%\t',vt,flagFA*100);
        
        % % Right-handed Limit
%         if flagFA > pfa_target
%             vt_low = vt;
%             vt = vt + ((vt_high - vt_low) / 2);
%             fprintf('Half Upper\n');
%             if (-1*(pfa_target - flagFA)) < Scaler_prec
%                 vt = vt_low;
%                 pfa = flagFA;
%                 fprintf('Complete!\n');
%                 break;
%             end
%         else
%             vt_high = vt;
%             vt = vt - ((vt_high - vt_low) / 2);
%             fprintf('Half Lower\n');
%         end
        
        % % Left-handed Limit
        if flagFA < pfa_target
            vt_high = vt;
            vt = vt - ((vt_high - vt_low) / 2);
            fprintf('Half Lower\n');
            if (pfa_target - flagFA) < Scaler_prec
                vt = vt_high;
                pfa = flagFA;
                fprintf('Complete!\n');
                break;
            end
        else
            vt_low = vt;
            vt = vt + ((vt_high - vt_low) / 2);
            fprintf('Half Upper\n');
        end

    end
    
end