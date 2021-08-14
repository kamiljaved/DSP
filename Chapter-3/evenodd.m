% [Chp 2 Section 2.1 Page 34]

% function: Real signal decomposition into even and odd parts

% <syntax>
% [xe, xo, m] = evenodd(x, n)

function [xe, xo, m] = evenodd(x, n)

if any(imag(x) ~= 0) 
    error('x is not a real sequence');
end

[xflp, nflp] =  sigfold(x, n);
[xe, m] = sigadd(x, n, xflp, nflp);
xe = 0.5*xe;
[xo, m] = sigadd(x, n, -xflp, nflp);
xo = 0.5*xo;

end
