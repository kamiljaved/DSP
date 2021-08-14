% [Chp 4 Section 4.2 Page 110]
%
%  EXAMPLE 4.6
%  
%  Using z-transform properties and the z-transform table, determine the z-transform of:
%           x[n] = (n − 2)(0.5)^(n−2)*cos(π/3*(n − 2))u[n − 2]
%
%  To check that calculated X(z) is indeed the correct expression, compute the first 
%  eight samples of the sequence x[n] corresponding to X(z).
%

% >>>>> MATLAB verfification <<<<<

% assume x[n] = h[n] = h[n] ∗ 𝛿[n]

% b's and a's in H(z)
b = [0 0 0 0.25 -0.5 0.0625]; 
a = [1 -1 0.75 -0.25 0.0625];

% <syntax> [x, n] = impseq(n0, n1, n2) where n1 <= n0 <= n2
[delta, n] = impseq(0, 0, 7);

% compute z-inverse of X(z) using filter() with 𝛿[n] (impulse response)
x = filter(b, a, delta)

% calc. some x[n] values using known n-domain expression of x[n]
x_expected = [(n-2).*(0.5).^(n-2).*cos(pi/3*(n-2))].*stepseq(2, 0, 7)

isequal(round(x, 10), round(x_expected, 10))
