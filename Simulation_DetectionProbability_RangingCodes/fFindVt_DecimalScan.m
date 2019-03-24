function [vt, pfa] = fFindVt_DecimalScan(Type, pfa_target, Scaler_prec, CN_dB, nNumPRN, CorrOut, nLenCode, sigma, vt_init, scale_init)
    bWhileEnd = 0;
    Scaler = scale_init;
    cnt_Scaler = 1;

    targetPRN1 = 1:nNumPRN;

    vt = vt_init; 
    
    while(1)
        FA_CorrOut_Auto = zeros(nNumPRN,1);
        for lpPRN1 = targetPRN1
            if strcmp(Type,'Auto')
                targetPRN2 = 1;
            elseif strcmp(Type,'Cross')
                targetPRN2 = (1:nNumPRN-lpPRN1+1);
            end

            nCntCross = 0;
            for lpPRN2 = targetPRN2
                FA_temp = zeros(nLenCode,1);
                for lpChip = 1:nLenCode
                    CN = 10^(CN_dB/10) * 0.001 * abs(CorrOut(lpPRN1).CorrOut_Norm(lpChip,lpPRN2))^2;
                    nu = sqrt(2*(CN));
                    QM_a = nu / sigma;
                    FA_temp(lpChip,1) = marcumq(QM_a,vt,1);
                end
                
                nCntCross = nCntCross + 1;
                if lpPRN2 == 1
                    FA_CorrOut_Auto(lpPRN1) = FA_CorrOut_Auto(lpPRN1) + mean(FA_temp(2:nLenCode,1));
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
%         if flagFA > pfa_target
%             vt = vt + Scaler;
%             cnt_Scaler = cnt_Scaler + 1;
%             fprintf('Vt+Scaler\n');
%         else
%             vt = vt - Scaler;
%             Scaler = Scaler * 0.1;
%             cnt_Scaler = 0;
%             if Scaler < Scaler_prec
%                 bWhileEnd = 1;
%                 fprintf('Complete!\n');
%             else
%                 vt = vt + Scaler;
%                 cnt_Scaler = cnt_Scaler + 1;
%                 fprintf('Vt-Scaler, Scaler/10 than Vt+Scaler\n');
%             end
%         end
        
        % % Left-handed Limit
        if flagFA < pfa_target
            vt = vt - Scaler;
            cnt_Scaler = cnt_Scaler + 1;
            fprintf('Vt-Scaler\n');
        else
            vt = vt + Scaler;
            Scaler = Scaler * 0.1;
            cnt_Scaler = 0;
            if Scaler < Scaler_prec
                bWhileEnd = 1;
                fprintf('Complete!\n');
            else
                vt = vt - Scaler;
                cnt_Scaler = cnt_Scaler + 1;
                fprintf('Vt+Scaler, Scaler/10 than Vt-Scaler\n');
            end
        end

    end
    
end