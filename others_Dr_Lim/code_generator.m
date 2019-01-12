function [ code ] = code_generator( svnum )
%UNTITLED2 이 함수의 요약 설명 위치
%   자세한 설명 위치
g2shift = [5 6 7 8 17 18 139 140 141 251 252 254 255 256 257 ...
            258 469 470 471 472 473 474 509 512 513 514 515 516 859 860 861 862];
        
% G1 code
reg1 = -1*ones(1,10);
for i=1:1023
    g1(i) = reg1(10);
    save1 = reg1(3)*reg1(10);
    reg1(2:10) = reg1(1:9);
    reg1(1) = save1;
end

% G2 code
reg2 = -ones(1,10);
for i=1:1023
    g2(i) = reg2(10);
    save2 = reg2(2)*reg2(3)*reg2(6)*reg2(8)*reg2(9)*reg2(10);
    reg2(2:10) = reg2(1:9);
    reg2(1) = save2;
end

% shift G2 code
g2temp(1:g2shift(svnum)) = g2(1023-g2shift(svnum)+1:1023);
g2temp(g2shift(svnum)+1:1023) = g2(1:1023-g2shift(svnum));
g2 = g2temp;

code = -(g1.*g2);

for i=1:1023
    if code(i) == -1
        code(i) = 0;
    end
end

temp = 0;
for i=1:10
    temp = temp+code(i)*2^(10-i);
end
temp;

end