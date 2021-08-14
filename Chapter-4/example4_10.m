% [Chp 4 Section 4.3 Page 117]
%
%  EXAMPLE 4.10
%  
%  Determine the inverse z-transform of
%           X(z) = (1 + 0.4√2z^−1) / (1 − 0.8√2z^−1 + 0.64z^−2)
%  so that the resulting sequence is causal and contains no complex numbers.
%

% >>>>> solution <<<<<

% b's and a's in poly frac X(z) = B(z)/A(z) (power 0 onwards) are,
b = [1 0.4*sqrt(2)];
a = [1 -0.8*sqrt(2) 0.64];

% compute partial fraction form
[R, p, C] = residuez(b, a)

% pole magnitudes
p_mag = abs(p)'
% pole angles in pi units
p_ang = angle(p)'/pi

% which gives
%           X(z) =   (0.5−j)/(1−0.8e^(+jπ/4)z^−1) 
%                  + (0.5+j)/(1−0.8e^(−jπ/4)z^−1), |z| > 0.8
% inverse z-transform is
%           x[n] = 0.8^n [cos(πn/4) + 2sin(πn/4)] u[n]

% MATLAB verfifcation

% <syntax> [x, n] = impseq(n0, n1, n2) where n1 <= n0 <= n2
[delta, n] = impseq(0, 0, 7);

% compute z-inverse of X(z) using filter() with 𝛿[n] (impulse response)
x = filter(b, a, delta)

% calc. some x[n] values using known n-domain expression of x[n]
x_expected =  (0.8.^n).*(cos(pi*n/4)+2*sin(pi*n/4))

isequal(round(x, 10), round(x_expected, 10))
