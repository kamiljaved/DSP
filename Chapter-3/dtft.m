% <function>
% computes DTFT of given sequence over the frequencies w0 to wM,
% with total M+1 frequency points.
%
% <syntax>
% [Xw, w, Xw_mag, Xw_ang, Xw_real, Xw_imag] = dtft(x, n, M)
%
% <I/O>
% Xw = DTFT of x[n], computed numerically over w = [w0, wM] with step = (wM-w0)/M.
% w = accompanying frequency-axis values in range [w0, wM] (M+1 values)
% Xw_mag, Xw_ang = magnitude and phase of DTFT
% Xw_real, Xw_imag = real and imaginary parts of DTFT
% x = input sequence x[n]
% n = accompanying n-axis values
% M = determines frequency-step ((wM-w0)/M), resulting in M+1 values of w

function [Xw, w, Xw_mag, Xw_ang, Xw_real, Xw_imag] = dtft(x, n, M, w0, wM)

if ~(nargin >= 3)
    M = 500;
end

if ~(nargin == 5)
    w0 = 0;
    wM = pi;
end

if ~any([2 4 6] == nargout)
    error('Wrong Number of Output Arguments. Allowed: 2, 4, 6.');
end


% compute DTFT numerically by X(w) formula

w = w0:(wM-w0)/M:wM;                    % M+1 values of w in [w0, wM]

% k = w*(M/pi);                           % k = k0, k1, ..., 0, 1, ..., kM. (M+1 points)
% Xw = x * exp(-1i * pi/M * n' * k);      % results in 1 x M+1 size matrix

% equivalently:
Xw = x * exp(-1i * n' * w);             % results in 1 x M+1 size matrix

if nargout >= 4
    % obtain mag., phase, and real, imaginary parts of X(w)
    Xw_mag = abs(Xw);
    Xw_ang = angle(Xw);
    if nargout == 6
        Xw_real = real(Xw);
        Xw_imag = imag(Xw);
    end
end

end