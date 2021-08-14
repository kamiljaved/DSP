% TASK-1 (Lab 6) assigned on 17/05/2021
% [Chp 2 Section 2.5 Page 54] (PROBLEM 2.7)
%
% <function>
% signal decomposition into conjugate-symmetric (xe[n]) and 
% conjugate-antisymmetric (xo[n]) parts
%
% <syntax>
% [xe, xo, m] = evenodd(x, n)
%
% <I/O>
% x = input sequence x[n] (over DT points 'n')
% xe = conjugate-symmetric part of x[n], given by xe[n] = (x[n]+x*[-n])/2
% xo = conjugate-antisymmetric part of x[n], given by xo[n] = (x[n]-x*[-n])/2

function [xe, xo, m] = evenodd(x, n)

    % obtain the time-reversed version of x[n]
    [xflp, nflp] =  sigfold(x, n);

    % obtain the conjugate x*[-n]
    xflpc =  conj(xflp);

    % conjugate-symmetric part of x[n], xe[n] = (x[n]+x*[-n])/2
    [xe, m] = sigadd(x, n, xflpc, nflp);
    xe = 0.5*xe;
    
    % conjugate-antisymmetric part of x[n], xo[n] = (x[n]-x*[-n])/2
    [xo, m] = sigadd(x, n, -xflpc, nflp);
    xo = 0.5*xo;

end
