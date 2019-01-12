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

colZADD1023_0 = zeros(length,size(u_1023,2));
% colZADD1023_1 = zeros(length,size(u_1023,2));
% colZADD1023_10 = zeros(length,size(u_1023,2));
% colZADD1023_100 = zeros(length,size(u_1023,2));
for lp = 1:size(u_1023,2)
    colZADD1023_0(:,lp) = fgPolyphase_ZaddofChu(length, u_1023(lp),0);
%     colZADD1023_1(:,lp) = fgPolyphase_ZaddofChu(length, u_1023(lp),1);
%     colZADD1023_10(:,lp) = fgPolyphase_ZaddofChu(length, u_1023(lp),10);
%     colZADD1023_100(:,lp) = fgPolyphase_ZaddofChu(length, u_1023(lp),100);
end
save CodeSequence_Polyphase_ZadoffChu_1023_0 colZADD1023_0;
% save CodeSequence_Polyphase_ZadoffChu_1023_1 colZADD1023_1;
% save CodeSequence_Polyphase_ZadoffChu_1023_10 colZADD1023_10;
% save CodeSequence_Polyphase_ZadoffChu_1023_100 colZADD1023_100;