% [Chp 2 Section 2.3 Page 44]

% modified convolution function, to accept and compute n axes

% <syntax>
% [y, ny] = conv_m(x, nx, h, nh)
% <I/O>
% [y, ny] = convolution result
% [x, nx] = signal 1
% [h, nh] = signal 2

function [y, ny] = conv_m(x, nx, h, nh)

nyb = nx(1) + nh(1);                    % beginning n value for y
nye = nx(length(x))+ nh(length(h));     % ending n value for y
% or, assuming sequence and their n vector of same length
% nye = nx(end) + nh(end);
ny = nyb:nye;                           % n vector for y[n]
y = conv(x, h);                         % call in-built conv() function

end


