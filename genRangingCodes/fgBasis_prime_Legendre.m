function colOut = fgBasis_prime_Legendre(nLength)
% Reference: IS-GPS-800D
%            section 3.2.2.1.1
% 
% 이하 Mathwork 홈페이지에서 참조.
% URL: https://kr.mathworks.com/matlabcentral/fileexchange/46890-qrseq-m
% 
% 함수명, 함수 입력/출력인자의 이름과 형태를 바꾸었고, 주석을 추가함.
% 또한, 생성된 시퀀드에 1/0/-1의 세 가지 심볼이 존재하던 것을 1, 0으로 수정.
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%QRSEQ Quadratic residue sequences.
% Row vector ls is the Legendre sequence of length p, p an odd prime.
% The Legendre sequence can be used to form binary sequences with good
% correlation properties [1,2].
%
% Example: 
% p = 7; ls = qrseq(p); disp(ls);
% % ls is an eigenvector of the discrete Fourier transform [2].
% Ls = fft(ls)/sqrt(p);   % Unitary DFT
% E = Ls(2); V = Ls/E;    % Eigenvalue and eigenvector of the DFT
% disp(V); ok = all(V == ls)
%
% References:
% [1] P. Borwein, K. K. S. Choi, and J. Jedwab. 
% Binary sequences with merit factor greater than 6.34, 
% IEEE Trans. Inf. Theory, 50(12), December 2004
%
% [2] Berthold K. P. Horn, Interesting eigenvectors of the Fourier
% transform, Transactions of the Royal Society of South Africa,
% Vol. 65(2), June 2010, 100-106
%
% Also see Wikipedia articles 'Legendre symbol', 'Quadratic reciprocity',
% and 'Quadratic residue'.
% 
% Limitations:
% Direct calculation in double precision limits the size of the prime. An
% error is thrown for p too large. On my machine this is p > 189,812,507.
% This method does not usefully generalize to residues of higher powers.
%
% See: primes

% 2014-06-07 Robert Dickson
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

if nLength<3 || ~isprime(nLength) 
    error('qrseq:primality', 'p must be an odd prime.');
end

if eps((nLength/2)^2) > 1
    error('qrseq:toobig', 'p is too large.');
end

colOut = zeros(nLength,1);
colOut(1+mod((1:(nLength-1)/2).^2,nLength)) = 1;
% index에 +1을 한 이유는 Matlab의 첫번째 index가 0이 아니기 때문.
end