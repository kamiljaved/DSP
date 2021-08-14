% [Chp 4 Section 4.2 Page 108]
%
%  EXAMPLE 4.5
%  
%  Let X1(z) = z + 2 + 3z^−1, and let X2(z) = 2z^2 + 4z + 3 + 5z^−1.
%  Determine X3(z) = X1(z)X2(z).
%

% >>>>> solution <<<<<

% the inverse z-transforms will be
% x1[n] = {1, 2, 3}
%             ↑
n1 = -1:1;
x1 = [1 2 3];
% x2[n] = {2, 4, 3, 5}
%                ↑
n2 = -2:1;
x2 = [2 4 3 5];

% so x3[n] = Z-inv[ X1(z)X2(z) ] = x1[n] ∗ x2[n]
[x3, n3] = conv_m(x1, n1, x2, n2)

% take z-transform
syms z;
X3 = x3*(z.^-n3).'

% deconvolution (example 4.5)
[x2, n2, r, nr] = deconv_m(x3, n3, x1, n1);
