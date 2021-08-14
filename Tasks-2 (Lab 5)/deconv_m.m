% TASK (Lab 5 / Chapter 4) assigned on 03/05/2021
% [Chp 4 Section 4.6 Page 136]
%
% PROBLEM 4.10
%
% <function>
% modified deconvolution routine for noncausal sequences
%
% <syntax>
% [p, np, r, nr] = deconv_m(b, nb, a, na)
%
% <I/O>
% b = numerator polynomial of support nb1 <= n <= nb2,      nb = [nb1, nb2]
% a = denominator polynomial of support na1 <= n <= na2,    na = [na1, na2]
% p = polynomial part of support np1 <= n <= np2,           np = [np1, np2]
% r = remainder part of support nr1 <= n <= nr2,            nr = [nr1, nr2]

function [p, np, r, nr] = deconv_m(b, nb, a, na)

% perform deconvolution using inbuilt MATLAB function
[p, r] = deconv(b, a);

% compute n-axis values for quotient p
np_b = nb(1) - na(1);                   % beginning n value for p
np_e = np_b + length(p) - 1;            % ending n value for p
np = np_b:np_e;

% compute n-axis values for remainder r
nr_b = nb(1);                           % beginning n value for r
nr_e = nr_b + length(r) - 1;            % ending n value for r
nr = nr_b:nr_e;

end
