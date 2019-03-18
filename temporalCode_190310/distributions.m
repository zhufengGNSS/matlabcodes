rv = 0:0.01:15;  % random variables
sigma = 1;      % RMS of Noise Power
Kc = 1;

% Setting Parameter
QM_b = rv / sigma;


%% Rayleigh Distribution
% PDF
Pn_Ray = (rv ./ sigma^2) .* exp(-1*(rv.^2 / (2*sigma^2)));

figure;
hold on;
plot(rv,Pn_Ray);

% CDF
Pn_Ray_CDF = 1 - exp(-rv.^2/(2*sigma^2));

figure;
hold on;
plot(rv,Pn_Ray_CDF);

%% Rician Distribution
% PDF
CN_dB = 45;
CN_GPS1 = 10^(CN_dB/10) * 0.001 * ( 1/1023)^2;
CN_GPS2 = 10^(CN_dB/10) * 0.001 * (63/1023)^2;
CN_GPS3 = 10^(CN_dB/10) * 0.001 * (65/1023)^2;

x_GPS1 = rv * sqrt(2*CN_GPS1) / sigma;
x_GPS2 = rv * sqrt(2*CN_GPS2) / sigma;
x_GPS3 = rv * sqrt(2*CN_GPS3) / sigma;

% I0_GPS1 = exp(x_GPS1) / sqrt(2*pi*x_GPS1);
% I0_GPS2 = exp(x_GPS2) / sqrt(2*pi*x_GPS2);
% I0_GPS3 = exp(x_GPS3) / sqrt(2*pi*x_GPS3);
I0_GPS1 = besseli(0,rv*sqrt(2*CN_GPS1)/sigma);
I0_GPS2 = besseli(0,rv*sqrt(2*CN_GPS2)/sigma);
I0_GPS3 = besseli(0,rv*sqrt(2*CN_GPS3)/sigma);

Pn_Rice_GPS1 = (rv ./ sigma^2) .* exp(-1*((rv.^2 / (2*sigma^2)) + CN_GPS1)) .* I0_GPS1;
Pn_Rice_GPS2 = (rv ./ sigma^2) .* exp(-1*((rv.^2 / (2*sigma^2)) + CN_GPS2)) .* I0_GPS2;
Pn_Rice_GPS3 = (rv ./ sigma^2) .* exp(-1*((rv.^2 / (2*sigma^2)) + CN_GPS3)) .* I0_GPS3;

plot(rv,Pn_Rice_GPS1);
plot(rv,Pn_Rice_GPS2);
plot(rv,Pn_Rice_GPS3);

legend rayleigh gps1 gps2 gps3


% CDF
nu_GPS1 = sqrt(2*(CN_GPS1));
nu_GPS2 = sqrt(2*(CN_GPS2));
nu_GPS3 = sqrt(2*(CN_GPS3));

QM_a_GPS1 = nu_GPS1 / sigma;
QM_a_GPS2 = nu_GPS2 / sigma;
QM_a_GPS3 = nu_GPS3 / sigma;

Pn_Rice_CDF_GPS1 = 1 - marcumq(QM_a_GPS1,rv/sigma,1);
Pn_Rice_CDF_GPS2 = 1 - marcumq(QM_a_GPS2,rv/sigma,1);
Pn_Rice_CDF_GPS3 = 1 - marcumq(QM_a_GPS3,rv/sigma,1);

plot(rv,Pn_Rice_CDF_GPS1);
plot(rv,Pn_Rice_CDF_GPS2);
plot(rv,Pn_Rice_CDF_GPS3);

legend rayleigh gps1 gps2 gps3