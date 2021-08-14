% TEST
%
% to test the function "corr_m()"
% by comparing it with the folding+convolution method for correlation
%

x = [3 11 7 0 -1 4 2]; 
nx = -3:3;
 
% generate y[n] from x[n]
[y1, ny1] = sigshift(x, nx, 2);
w = randn(1, length(y1));
nw = ny1;
[y, ny] = sigadd(y1, ny1, w, nw);
    
% [using sigfold() and conv_m()]

% cross correlation = ryx[l] = y[l] ∗ x[-l]
[xf, nxf] = sigfold(x, nx);
[ryx, nryx] = conv_m(y, ny, xf, nxf);

% plot
subplot(2, 2, 1);
stem(nryx, ryx);
xlabel('Lag Variable l'); ylabel('r_{yx}[l]');
title(['[Cross-corr] using sigfold+conv\_m'])
    
% auto correlation = rxx[l] = x[l] ∗ x[-l]
[xf, nxf] = sigfold(x, nx);
[rxx, nrxx] = conv_m(x, nx, xf, nxf);

% plot
subplot(2, 2, 2);
stem(nrxx, rxx);
xlabel('Lag Variable l'); ylabel('r_{xx}[l]');
title(['[Auto-corr] using sigfold+conv\_m'])

% [using corr_m()]

% cross correlation = ryx[l] = y[l] ∗ x[-l]
[ryx, nryx] = corr_m(y, ny, x, nx);

% plot
subplot(2, 2, 3);
stem(nryx, ryx);
xlabel('Lag Variable l'); ylabel('r_{yx}[l]');
title(['[Cross-corr] using corr\_m'])
    
% auto correlation = rxx[l] = x[l] ∗ x[-l]
[rxx, nrxx] = corr_m(x, nx);

% plot
subplot(2, 2, 4);
stem(nrxx, rxx);
xlabel('Lag Variable l'); ylabel('r_{xx}[l]');
title(['[Auto-corr] using corr\_m'])
