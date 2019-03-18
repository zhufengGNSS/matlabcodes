k = 1.3806488e-23;
T0 = 273;
N0 = k*T0;
N0_dB = 10*log10(N0);

N0_BPF = N0 * 2e6;
N0_BPF_dB = 10*log10(N0_BPF);

Sr_db = -160;