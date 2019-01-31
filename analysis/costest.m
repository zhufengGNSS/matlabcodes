time = 0:1/64:10;

sig = cos(2*pi*1*time);

fFs = 64;

[dBWHz, nfft] = fPlotPSD(sig, fFs , 0,10);
