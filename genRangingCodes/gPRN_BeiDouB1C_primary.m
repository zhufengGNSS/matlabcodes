%% B1C Code Generation
colB1Cp = zeros(10230, 63);
colB1Cd = zeros(10230, 63);
for prn = 1:63
    [tp, td] = fgPRN_BeiDouB1C(prn);
    colB1Cp(:,prn) = tp;
    colB1Cd(:,prn) = td;
end
colB1Cp = logic2unrz(colB1Cp);
colB1Cd = logic2unrz(colB1Cd);
save CodeSequence_PRN_BDSB1C colB1Cp colB1Cd;