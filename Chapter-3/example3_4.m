% [Chp 3 Section 3.1 Page 63]
%
%  EXAMPLE 3.4
%  
%  Numerically compute the discrete-time Fourier transform of the sequence 
%  x[n] given in Example 3.2 at 501 equispaced frequencies between [0, π].
%

% >>>>> solution <<<<<

% x[n] = {1, 2, 3, 4, 5}
%            ↑

x = 1:5;
n = -1:3;

% compute DTFT numerically by X(w) formula
M = 500;                                % for 501 values, from 0 to 500
k = 0:M;                                % k = 0, 1, ..., M. (501 points)
w = (pi/M)*k;                           % 501 values of w in [0, pi]
Xw = x * exp(-1i * pi/M * n' * k);      % results in 1 x M+1 size matrix
% equivalently:
% Xw = x * (exp(-1i * pi/M) .^ (n' * k));
% isequal(round(Xw, 10), round(Xw2, 10))

% obtain mag., phase, and real, imaginary parts of X(w)
Xw_mag = abs(Xw);
Xw_ang = angle(Xw);
Xw_real = real(Xw);
Xw_imag = imag(Xw);

% equivalently:
% [Xw, w, Xw_mag, Xw_ang, Xw_real, Xw_imag] = dtft(x, n, M);
% or:
% [Xw, w, Xw_mag, Xw_ang, Xw_real, Xw_imag] = dtft(x, n, M, 0, pi);

% plot the different parts of X(w)
fig = figure;
% [mag. and phase]
subplot(2, 2, 1);
plot(w/pi, Xw_mag);
xlabel('Frequency in \pi units (w/\pi)');
ylabel('|X(e^{jw})|');
title('Magnitude of X(e^{jw}) vs w/\pi');
subplot(2, 2, 3);
plot(w/pi, Xw_ang);
xlabel('Frequency in \pi units (w/\pi)');
ylabel('∠X(e^{jw})   (radians)');
title('Phase of X(e^{jw}) vs w/\pi');
% [real and imaginary]
subplot(2, 2, 2);
plot(w/pi, Xw_real);
xlabel('Frequency in \pi units (w/\pi)');
ylabel('Real\{ X(e^{jw}) \}');
title({'';'Real Part of X(e^{jw}) vs w/\pi'});
subplot(2, 2, 4);
plot(w/pi, Xw_imag);
xlabel('Frequency in \pi units (w/\pi)');
ylabel('Imag\{ X(e^{jw}) \}');
title({'';'Imaginary Part of X(e^{jw}) vs w/\pi'});

