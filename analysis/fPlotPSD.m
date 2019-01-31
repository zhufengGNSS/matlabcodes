function [dBWHz, nfft] = fPlotPSD(input, fs, nFFT, nMA)
%[dBWHz, AvgPow, AvgPowBW, nfft] = fPlotPSD(input, f0, fs, nFFT, nMA)
    % AvgPow: Average Power of whole frequencies
    % AvgPowBW: Average Power of GPS L1 band


    if nFFT == 0
        x = input;
        Nxx         = abs(fft(x)).^2/length(x)/fs;
        nfft = 0;
    else
        ed  = length(input);
        x = input(:,ed-nFFT+1:ed);
        nfft = 2^nextpow2(length(x));

        Nxx         = abs(fft(x,nfft)).^2/length(x)/fs;
    end
    %Nxx_dB      = dspdata.psd(   Nxx(1:length(Nxx)/2),   'Fs',fs);
    Nxx_dB = 10*log10(Nxx);
    len2 = floor(length(Nxx)/2);
    freq = 1/len2:1/len2:1;
    freq = freq * (fs/2)*1e-6;
    
%     AvgPow      = 10*log10( avgpower( Nxx_dB(1:len2) ) );
%     if f0 > (fs/2)
%         AvgPowBW    = 10*log10( avgpower( Nxx_dB(1:len2), [(fs-f0)- 1.023e6, (fs-f0) + 1.023e6] ) );
%     else
%         AvgPowBW    = 10*log10( avgpower( Nxx_dB(1:len2), [f0 - 1.023e6, f0 + 1.023e6] ) );
%     end
    

    figure;
    hold on;    grid on; 
    dB = plot(freq,Nxx_dB(1:len2));
    fStylePSD(dB);
    set(dB, 'Color', [0 0 0])

    if (nMA~=0)
        Nxx_ma      = movavg(Nxx, nMA/2, nMA/2, 2);
        %Nxx_ma_dB   = dspdata.psd(Nxx_ma(1:length(Nxx_ma)/2),'Fs',fs);  
        Nxx_ma_dB = 10*log10(Nxx_ma);
        dBWHz       = mean(10*log10(Nxx_ma));

        dB_ma = plot(freq,Nxx_ma_dB(1:len2));
        fStylePSD(dB_ma);
        set(dB_ma, 'Color', [0 1 0])
    else
        dBWHz       = 'null';
    end
end