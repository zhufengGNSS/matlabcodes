
verityGPSL1CA;
colL1CA = (colL1CA * 2) - 1;
save CodeSequence_PRN_GPSL1CA colL1CA;

verifyGPSL1C;
colL1Cp = (colL1Cp * 2) - 1;
colL1Cd = (colL1Cd * 2) - 1;
save CodeSequence_PRN_GPSL1C colL1Cp colL1Cd;

verifyBeiDouB1C_primary;
colB1Cp = (colB1Cp * 2) - 1;
colB1Cd = (colB1Cd * 2) - 1;
save CodeSequence_PRN_BDSB1C colB1Cp colB1Cd;

gPRN_GalileoE1b;
colE1b = (colE1b * 2) - 1;
save CodeSequence_PRN_GALE1b colE1b;

gPRN_GalileoE1c;
colE1c = (colE1c * 2) - 1;
save CodeSequence_PRN_GALE1c colE1c;