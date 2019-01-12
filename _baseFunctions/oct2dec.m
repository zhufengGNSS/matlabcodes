function nOut = oct2dec(strInOct)
    d = 0;
    
    f = fliplr(strInOct);
    
    for p = 0:length(strInOct) - 1
        %d = d + str2num(f(p+1)) * 8^p;
        d = d + str2double(f(p+1)) * 8^p;
    end
    nOut = d;
end