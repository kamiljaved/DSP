% [Chp 3 Section 3.1 Page 61]
%
%  EXAMPLE 3.3
%  
%  Evaluate X(e^{jω}) in Example 3.1 at 501 equispaced points between [0, π] 
%  and plot its magnitude, angle, real part, and imaginary part.
%

% >>>>> solution <<<<<

% x[n] = (0.5)^n u[n]
% X(w) = e^jw / (e^jw - 0.5)

% compute DTFT by X(w) equation
w = 0:(pi-0)/500:pi;                    % w = [0, pi] (501 points)
Xw = exp(1i*w) ./ (exp(1i*w) - 0.5);    % MATLAB: for improved robustness, consider replacing i and j by 1i
% equivalently:
% Xw = exp(1i*w) ./ (exp(1i*w) - 0.5*ones(1, length(w)));

% obtain mag., phase, and real, imaginary parts of X(w)
Xw_mag = abs(Xw);
Xw_ang = angle(Xw);
Xw_real = real(Xw);
Xw_imag = imag(Xw);

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

