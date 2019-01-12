%% L1C Code Generation
colL1Cp = zeros(10230, 63);
colL1Cd = zeros(10230, 63);
for prn = 1:63
    [tp, td] = fgPRN_GPSL1C(prn);
    colL1Cp(:,prn) = tp;
    colL1Cd(:,prn) = td;
end
colL1Cp = logic2unrz(colL1Cp);
colL1Cd = logic2unrz(colL1Cd);
save CodeSequence_PRN_GPSL1C colL1Cp colL1Cd;