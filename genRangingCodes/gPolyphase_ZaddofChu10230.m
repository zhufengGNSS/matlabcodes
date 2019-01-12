%% 10230 length Zadoff-chu
length = 10230;
lpCnt = 1;
u_candidate = [];
for lp = 1:(length-1)
    if gcd(length,lp) == 1
        u_candidate(lpCnt) = lp;
        lpCnt = lpCnt + 1;
    end
end
u_10230 = u_candidate(1:end/2);

colZADD10230_0 = zeros(length,size(u_10230,2));
% colZADD10230_1 = zeros(length,size(u_10230,2));
% colZADD10230_10 = zeros(length,size(u_10230,2));
% colZADD10230_100 = zeros(length,size(u_10230,2));
for lp = 1:size(u_10230,2)
    colZADD10230_0(:,lp) = fgPolyphase_ZaddofChu(length, u_10230(lp),0);
%     colZADD10230_1(:,lp) = fgPolyphase_ZaddofChu(length, u_10230(lp),1);
%     colZADD10230_10(:,lp) = fgPolyphase_ZaddofChu(length, u_10230(lp),10);
%     colZADD10230_100(:,lp) = fgPolyphase_ZaddofChu(length, u_10230(lp),100);
end
save CodeSequence_Polyphase_ZadoffChu_10230_0 colZADD10230_0;
% save CodeSequence_Polyphase_ZadoffChu_10230_1 colZADD10230_1;
% save CodeSequence_Polyphase_ZadoffChu_10230_10 colZADD10230_10;
% save CodeSequence_Polyphase_ZadoffChu_10230_100 colZADD10230_100;