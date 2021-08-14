% TASK-5 (Lab 6) assigned on 17/05/2021
% [Chp 4 Section 4.6 Page 136] (PROBLEM 4.10)

% ------------
% Check your function "deconv_m()" on the following operation:
%           (z^2 + z + 1 + z^−1 + z^−2 + z^−3) / (z + 2 + z^−1) 
%           =
%           (z − 1 + 2z^−1 − 2z^−2) + (3z^−2 + 3z^−3) / (z + 2 + z^−1)
% ------------

% z-inv of numerator (dividend) i.e. b[n] <==> X3(z)
b = [1 1 1 1 1 1];
nb = -2:3;

% z-inv of denominator (divisor) i.e. a[n] <==> X1(z)
a = [1 2 1];
na = -1:1;

% perform deconvolution on non-causal sequences (b[n] deconv a[n])
[p, np, r, nr] = deconv_m(b, nb, a, na)

% result in z-domain X2(z) = X3(z)/X1(z), using results p & r from deconv_m()
syms z;
X2 = (p*(z.^-np).') + (r*(z.^-nr).')/(a*(z.^-na).')

% compare against known answer
X2_expected = (z - 1 + 2*z^-1 - 2*z^-2) + (3*z^-2 + 3*z^-3) / (z + 2 + z^-1);
if isequal(X2, X2_expected)
    disp(['The result of the deconv_m() function matches with the ',... 
        'given answer for deconvolution (or z-domain division).'])
end
