function [zadoffchu] = fgPolyphase_ZaddofChu(Ns, u, q) 
    n = 0:1:Ns-1;
    
    zadoffchu = zeros(length(n),1);
    zadoffchu_s = zeros(length(n),2);

    if rem(Ns,2) == 0 % ¦ even
        for lp = n
            zadoffchu_s(lp+1,1) =  cos((pi*u*lp*(lp+(2*q)))/Ns);
            zadoffchu_s(lp+1,2) = -sin((pi*u*lp*(lp+(2*q)))/Ns);
            zadoffchu(lp+1,:) = complex(zadoffchu_s(lp+1,1),zadoffchu_s(lp+1,2));
        end
    else % Ȧ odd
        for lp = n
            zadoffchu_s(lp+1,1) =  cos((pi*u*lp*(lp+1+(2*q)))/Ns);
            zadoffchu_s(lp+1,2) = -sin((pi*u*lp*(lp+1+(2*q)))/Ns);
            zadoffchu(lp+1,:) = complex(zadoffchu_s(lp+1,1),zadoffchu_s(lp+1,2));
        end
    end
end