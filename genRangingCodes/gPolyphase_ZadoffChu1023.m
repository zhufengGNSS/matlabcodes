%% 1023 length Zadoff-chu
length = 1023;
lpCnt = 1;
u_candidate = [];
for lp = 1:(length-1)
    if gcd(length,lp) == 1
        u_candidate(lpCnt) = lp;
        lpCnt = lpCnt + 1;
    end
end
u_1023 = u_candidate(1:end/2);

colPPZC1023_0 = zeros(length,size(u_1023,2));
% colPPZC1023_1 = zeros(length,size(u_1023,2));
% colPPZC1023_10 = zeros(length,size(u_1023,2));
% colPPZC1023_100 = zeros(length,size(u_1023,2));
for lp = 1:size(u_1023,2)
    colPPZC1023_0(:,lp) = fgPolyphase_ZadoffChu(length, u_1023(lp),0);
%     colPPZC1023_1(:,lp) = fgPolyphase_ZadoffChu(length, u_1023(lp),1);
%     colPPZC1023_10(:,lp) = fgPolyphase_ZadoffChu(length, u_1023(lp),10);
%     colPPZC1023_100(:,lp) = fgPolyphase_ZadoffChu(length, u_1023(lp),100);
end
save CodeSequence_Polyphase_ZadoffChu_1023_0 colPPZC1023_0;
% save CodeSequence_Polyphase_ZadoffChu_1023_1 colPPZC1023_1;
% save CodeSequence_Polyphase_ZadoffChu_1023_10 colPPZC1023_10;
% save CodeSequence_Polyphase_ZadoffChu_1023_100 colPPZC1023_100;