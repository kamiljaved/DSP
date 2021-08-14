% TEST
%
% to test the function "deconv_m()"
% for the following operation:
%       (z^2 + z + 1 + z^−1 + z^−2 + z^−3) / (z + 2 + z^−1) 
%       = 
%       (z − 1 + 2z^−1 − 2z^−2) + (3z^−2 + 3z^−3) / (z + 2 + z^−1)
%

% z-inv of numerator (dividend)
b = [1 1 1 1 1 1];
nb = -2:3;

% z-inv of denominator (divisor)
a = [1 2 1];
na = -1:1;

% perform doconvolution on non-causal sequences
[p, np, r, nr] = deconv_m(b, nb, a, na);

% result in z-domain
syms z;
X2 = (p*(z.^-np).') + (r*(z.^-nr).')/(a*(z.^-na).')

% compare against known answer
X2_expected = (z - 1 + 2*z^-1 - 2*z^-2) + (3*z^-2 + 3*z^-3) / (z + 2 + z^-1);
isequal(X2, X2_expected)
