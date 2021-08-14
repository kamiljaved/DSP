% [Chp 4 Section 4.5 Page 129,131]
%
%  EXAMPLE 4.14
%  
%  Solve
%           y[n] − 3/2 y[n−1] + 1/2 y[n−2] = x[n] , n ≥ 0
%  where
%           x[n] = (1/4)^n u[n]
%  subject to y[−1] = 4 and y[−2] = 10.
%

% >>>>> solution using MATLAB <<<<<

% solving analytically (for ZS and ZI response), we have,
%           xIC[n] = {1, −2}
%                     ↑
xIC = [1 -2];
n = 0:7;
x = (1/4).^n;

% b's and a's in the CCDE (b0, a0 onwards) are,
b = [1];
a = [1 -3/2 1/2];

% use filter() to solve CCDE with xIC (equivalent initial-condition input array)
y1 = filter(b, a, x, xIC)
 
% calc. some y[n] values using analytically derived n-domain expression of y[n]
y2 = (1/3)*(1/4).^n+(1/2).^n+(2/3)*ones(1,8)

isequal(round(y1, 10), round(y2, 10))

% computing xIC using Signal Processing Toolbox
% <syntax> xic = filtic(b, a, Y, X)
% where     Y = [y(−1), y(−2), ..., y(−N)]
% and       X = [x(−1), x(−2), ..., x(−M)]
% if x[n]=0, n ≤ −1, then X need not be specified in the filtic function
Y = [4 10];                         % given initial-conditions
xIC = filtic(b, a, Y)               % equivalent initial-condition input array

% NOTE:
% ------
% yh = o/p due to system poles
% yp = o/p due to input poles
% ------
% ytr = o/p due to poles inside unit circle
% yss = o/p due to poles at unit circle
% ------
% yZI = o/p due to init. system state alone (inp = 0)
% yZS = o/p due to input alone (i.c. = 0)
% ------
