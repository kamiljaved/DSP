% [Chp 4 Section 4.3 Page 116]
%
%  EXAMPLE 4.9
%  
%  Compute the inverse z-transform of
%           X(z) = 1 / ((1 − 0.9z−1)^2 * (1 + 0.9z−1)), |z| > 0.9
%

% >>>>> solution <<<<<

% b's and a's in poly frac X(z) = B(z)/A(z) (power 0 onwards) are,
b = [1];
% poly(r) returns the coefficients of the polynomial of form (x-a)(x-b)(x-c)... 
% whose roots are the elements of r.
a = poly([0.9 0.9 -0.9])

% compute partial fraction form
[R, p, C] = residuez(b, a)

% which gives
%           X(z) = 0.25/(1−0.9z^−1) + 0.5/(1−0.9z^−1)^2 + 0.25/(1+0.9z^−1), |z| > 0.9
% inverse z-transform is
%           x[n] = 0.75(0.9)^n u[n] + 0.5n(0.9)^n u[n] + 0.25(−0.9)^n u[n]

% MATLAB verfifcation

% <syntax> [x, n] = impseq(n0, n1, n2) where n1 <= n0 <= n2
[delta, n] = impseq(0, 0, 7);

% compute z-inverse of X(z) using filter() with 𝛿[n] (impulse response)
x = filter(b, a, delta)

% calc. some x[n] values using known n-domain expression of x[n]
x_expected = 0.75*0.9.^n + 0.5*n.*0.9.^n + 0.25*(-0.9).^n

isequal(round(x, 10), round(x_expected, 10))
