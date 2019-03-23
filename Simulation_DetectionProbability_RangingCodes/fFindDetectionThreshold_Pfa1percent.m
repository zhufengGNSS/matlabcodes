function vt = fFindDetectionThreshold_Pfa1percent(Type, Scaler_prec, CN_dB, nNumPRN, CorrOut, nLenCode, sigma, vt_init)
    bWhileEnd = 0;
    Scaler = 1;
    cnt_Scaler = 1;

    targetPRN1 = 1:nNumPRN;
    
    if Type == 'Auto'       
        targetPRN2 = 1;
    elseif Type == 'Cross'  
        targetPRN2 = 1:nNumPRN;
    end
    
    vt = vt_init; 
    
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
                
                if lpPRN1 == lpPRN2
                    FA_CorrOut_Auto(lpPRN1) = mean(FA_temp(2:nLenCode,1));
                else
                    FA_CorrOut_Auto(lpPRN1) = mean(FA_temp);
                end
            end
        end
        
        flagFA = mean(FA_CorrOut_Auto(:,1));
        flagFA
        
        if bWhileEnd == 1
            Scaler = 1;
            bWhileEnd = 0;
            break;
        end
        
        %if flagFA > Scaler_prec
        if flagFA > 0.01000000000
            vt = vt + Scaler;
            cnt_Scaler = cnt_Scaler + 1;
        else
            vt = vt - Scaler;
            Scaler = Scaler * 0.1;
            cnt_Scaler = 0;
            if Scaler < Scaler_prec
                bWhileEnd = 1;
            end
        end
    end
    
end