%% L1 C/A Code Generation
colL1CA = zeros(1023, 37);
for prn = 1:37
    to = fgPRN_GPSL1CA(prn);
    colL1CA(:,prn) = to;
end
colL1CA = logic2unrz(colL1CA);
save CodeSequence_PRN_GPSL1CA colL1CA;