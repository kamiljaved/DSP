% [Chp 2 Section 2.3 Page 45]
%
%  EXAMPLE 2.10
% 
%  x[n] = [3, 11, 7, 0, −1, 4, 2]
%                   ↑
%  y[n] = x[n − 2] + w[n]
%  where w[n] is a Gaussian sequence with mean 0 and variance 1.
%  Compute the cross-correlation between y[n] and x[n].
%

x = [3 11 7 0 -1 4 2]; 
nx = -3:3;
    
for i = 1:2

    % generate y[n] from x[n]
    [y1, ny1] = sigshift(x, nx, 2);
    w = randn(1, length(y1));           % new noise sequence
    nw = ny1;
    [y, ny] = sigadd(y1, ny1, w, nw);

    % cross correlation = ryx[l] = y[l] ∗ x[-l]
    [xf, nxf] = sigfold(x, nx);
    [ryx, nryx] = conv_m(y, ny, xf, nxf);
    
    % plot
    subplot(2, 1, i);
    stem(nryx, ryx);
    axis([-5, 10, -50, 250]);
    xlabel('Lag Variable l'); ylabel('ryx[l]');
    title(['Cross-correlation: Noise Sequence ' num2str(i)])
    
end