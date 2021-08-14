% [Chp 2 Section 2.1 Page 27]

% function: Implements y[n] = x[n-k]

% <syntax>
% [y,n] = sigshift(x,m,k)
% <I/O>
% m is the original horizontal axis
% k is the shift to be made in horizontal axis

function [y,n] = sigshift(x, m, k)

n = m+k;
y = x;

end