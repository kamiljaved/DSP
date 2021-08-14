% [Chp 4 Section 4.5 Page 132]
%
%  EXAMPLE 4.15
%  
%  Solve the difference equation
%           y[n] = 1/3 (x[n] + x[n−1] + x[n−2]) + 0.95y[n−1] − 0.9025y[n−2] , n ≥ 0
%  where
%           x[n] = cos(πn/3) u[n]
%  and
%           y[−1] = −2, y[−2] = −3; x[−1] = 1, x[−2] = 1
%  First determine the solution analytically and then by using MATLAB.
%

% >>>>> solution using MATLAB <<<<<

% b's and a's in the CCDE (b0, a0 onwards) are,
b = [1/3 1/3 1/3];                      % coeff.s of x[n-k]
a = [1 -0.95 0.9025];                   % coeff.s of y[n-k]

% compute equivalent initial-condition input array from given initial conditions
% i.e. xIC using Signal Processing Toolbox
Y = [-2 -3];                            % given i.c.s Y = [y(−1), y(−2), ..., y(−N)]
X = [1 1];                              % given i.c.s X = [x(−1), x(−2), ..., x(−M)]
xIC = filtic(b, a, Y, X)                % equivalent initial-condition input array

% coeff.s of X(z) z+ transform
b_xplus = [1 -0.5];
a_xplus = [1 -1 1];

% new b's and a's for Y(z) z+ transform, given X(z) input
a_yplus = conv(a, a_xplus)                          % denominator of Y(z) z+ tr.
b_yplus = conv(b, b_xplus) + conv(xIC, a_xplus)     % numerator of Y(z) z+ tr.

% compute partial fraction form of Y(z) z+ transform
[R, p, C] = residuez(b_yplus, a_yplus)
p_mag = abs(p)'                         % pole magnitudes
p_ang = angle(p)'/pi                    % pole angles in pi units

% which gives
%           Y+(z) = (1.8075 + 0.8308z^−1 − 0.4975z^−2 + 1.9717z^−3) /
%                   (1 − 1.95z^−1 + 2.8525z^−2 − 1.8525z^−3 + 0.9025z^−4)
%                 =   (0.0584 + j3.9468)/(1 − e^−jπ/3 z^−1)
%                   + (0.0584 − j3.9468)/(1 − e^+jπ/3 z^−1)
%                   + (0.8453 + j2.0311)/(1 − 0.95e^+jπ/3 z^−1)
%                   + (0.8453 − j2.0311)/(1 − 0.95e^−jπ/3 z^−1)
% inverse z-transform is
%           y[n] =  0.1169 cos(πn/3) + 7.8937 sin(πn/3) 
%                   + (0.95)^n [1.6906 cos(πn/3) − 4.0623 sin(πn/3)] , n ≥ 0
% here,
%           yss[n] = yp[n] = 0.1169 cos(πn/3) + 7.8937 sin(πn/3)
%           ytr[n] = yh[n] = + (0.95)^n [1.6906 cos(πn/3) − 4.0623 sin(πn/3)]

% obtain y[n] in MATLAB using filter() with x[n]=cos(πn/3)u[n], CCDE a's, b's, and xIC
n = 0:7; 
x = cos(pi*n/3);
y = filter(b, a, x, xIC)

% calc. some y[n] values using analytically derived n-domain expression of y[n]
A = abs(real(2*R(1))); B = abs(imag(2*R(1))); C = abs(real(2*R(3))); D = -abs(imag(2*R(4)));
y_expected = A*cos(pi*n/3) + B*sin(pi*n/3) + ((0.95).^n).*(C*cos(pi*n/3) + D*sin(pi*n/3))

isequal(round(y, 10), round(y_expected, 10))
