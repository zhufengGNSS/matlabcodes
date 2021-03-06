%% 4092 length Zadoff-chu
length = 4092;
lpCnt = 1;
u_candidate = [];
for lp = 1:(length-1)
    if gcd(length,lp) == 1
        u_candidate(lpCnt) = lp;
        lpCnt = lpCnt + 1;
    end
end
u_4092 = u_candidate(1:end/2);

colPPZC4092_0 = zeros(length,size(u_4092,2));
% colPPZC4092_1 = zeros(length,size(u_4092,2));
% colPPZC4092_10 = zeros(length,size(u_4092,2));
% colPPZC4092_100 = zeros(length,size(u_4092,2));
for lp = 1:size(u_4092,2)
    colPPZC4092_0(:,lp) = fgPolyphase_ZadoffChu(length, u_4092(lp),0);
%     colPPZC4092_1(:,lp) = fgPolyphase_ZadoffChu(length, u_4092(lp),1);
%     colPPZC4092_10(:,lp) = fgPolyphase_ZadoffChu(length, u_4092(lp),10);
%     colPPZC4092_100(:,lp) = fgPolyphase_ZadoffChu(length, u_4092(lp),100);
end
save CodeSequence_Polyphase_ZadoffChu_4092_0 colPPZC4092_0;
% save CodeSequence_Polyphase_ZadoffChu_4092_1 colPPZC4092_1;
% save CodeSequence_Polyphase_ZadoffChu_4092_10 colPPZC4092_10;
% save CodeSequence_Polyphase_ZadoffChu_4092_100 colPPZC4092_100;