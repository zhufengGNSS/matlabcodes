function colOut = fgPRN_prime_Weil(nCodeLength,nCodeIndex)
    
    if (nCodeIndex > floor(nCodeLength/2))
        error('Code Index is must smaller than "Code Length / 2".');
    end
    
    L = fgBasis_prime_Legendre(nCodeLength);
    
    colOut = zeros(nCodeLength,1);
    for lpIDX = 0:nCodeLength-1
        colOut(lpIDX+1) = xor(L(1+lpIDX), L(1+ mod(lpIDX+nCodeIndex,nCodeLength)));
    end
end