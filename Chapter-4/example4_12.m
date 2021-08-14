% [Chp 4 Section 4.4 Page 124]
%
%  EXAMPLE 4.12
%  
%  Given that
%           H(z) = (z + 1) / (z^2 − 0.9z + 0.81)
%  is a causal system, find
%  a. its transfer function representation,
%  b. its difference equation representation, and
%  c. its impulse response representation.
%

% >>>>> solution <<<<<

% (a)

% Substituting z = e^jω in H(z), we have
%           H(e^jω) = (e^jω + 1) / (e^j2ω − 0.9e^jω + 0.81)
%                   = (e^jω + 1) / ((e^jω − 0.9e^jπ/3)(e^jω − 0.9e−jπ/3))
 
% (b)

% using H(z) = Y (z)/X(z), we have
%           Y(z)/X(z) = (z^−1 + z^−2) / (1 − 0.9z^−1 + 0.81z^−2)
%           Y(z) − 0.9z^−1 Y(z) + 0.81z^−2 Y(z) = z^−1 X(z) + z^−2 X(z)
% taking the inverse z-transform
%           y[n] − 0.9y[n−1] + 0.81y[n−2] = x[n−1] + x[n−2]
% or
%           y[n] = 0.9y[n−1] − 0.81y[n−2] + x[n−1] + x[n−2]

% (c)

% impulse response representation h[n]

% b's and a's in poly frac H(z) = B(z)/A(z) (power 0 onwards) are,
b = [0 1 1];
a = [1 -0.9 0.81];

% compute partial fraction form
[R, p, C] = residuez(b, a)

% pole magnitudes
p_mag = abs(p)'
% pole angles in pi units
p_ang = angle(p)'/pi

% which gives
%           H(z) = 1.2346 + (−0.6173 + j0.9979)/(1 − 0.9e^−jπ/3 z^−1) 
%                         + (−0.6173 − j0.9979)/(1 − 0.9e^+jπ/3 z^−1), |z| > 0.9
% inverse z-transform is
%           h[n] = 0.9^n [−1.2346 cos(πn/3) + 1.9958 sin(πn/3)] u[n−1]
