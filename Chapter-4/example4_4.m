% [Chp 4 Section 4.2 Page 108]
%
%  EXAMPLE 4.4
%  
%  Let X1(z) = 2 + 3z^−1 + 4z^−2, and let X2(z) = 3 + 4z^−1 + 5z^−2 + 6z^−3. 
%  Determine X3(z) = X1(z)X2(z).
%

% >>>>> solution <<<<<

% the inverse z-transforms will be
% x1[n] = {2, 3, 4}
%          ↑
n1 = 0:2;
x1 = [2 3 4];
% x2[n] = {3, 4, 5, 6}
%          ↑
n2 = 0:3;
x2 = [3 4 5 6];

% so x3[n] = Z-inv[ X1(z)X2(z) ] = x1[n] ∗ x2[n]
[x3, n3] = conv_m(x1, n1, x2, n2)

% take z-transform
syms z;
X3 = x3*(z.^-n3).'

% deconvolution (example 4.4)
[x2, r] = deconv(x3, x1);
