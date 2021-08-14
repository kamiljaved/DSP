% [Chp 3 Section 3.1 Page 64]
%
%  EXAMPLE 3.5
%  
%  Let x[n] = (0.9*exp(jπ/3))^n , 0 ≤ n ≤ 10. Determine X(e^jω) and 
%  investigate its periodicity.
%

% >>>>> solution <<<<<

% x[n] is complex-valued, so X(e^jω) satisfies only the periodicity property.
% Therefore, it is uniquely defined over one period of 2π. 
% However, we will evaluate and plot it at 401 frequencies over two periods 
% between [−2π, 2π] to observe its periodicity.

n = 0:10;
x = (0.9*exp(1i*pi/3)).^n;

% compute DTFT numerically by X(w) formula
k = -200:200;
w = (pi/100)*k;
Xw = x * exp(-1i * pi/100 * n' * k);
% equivalently:
% Xw = x * (exp(-1i * pi/M) .^ (n' * k));
% isequal(round(Xw, 10), round(Xw2, 10))

% obtain mag., phase, and real, imaginary parts of X(w)
Xw_mag = abs(Xw);
Xw_ang = angle(Xw);

% equivalently:
% [Xw, w, Xw_mag, Xw_ang] = dtft(x, n, 400, -2*pi, 2*pi);

% plot the different parts of X(w)
fig = figure;
% [mag. and phase]
subplot(2, 1, 1);
plot(w/pi, Xw_mag);
xlabel('Frequency in \pi units (w/\pi)');
ylabel('|X(e^{jw})|');
xlim([min(w/pi) max(w/pi)]);
title('Magnitude of X(e^{jw}) vs w/\pi'); grid;
subplot(2, 1, 2);
plot(w/pi, Xw_ang/pi);
xlabel('Frequency in \pi units (w/\pi)');
ylabel('∠X(e^{jw})   (radians/\pi)');
xlim([min(w/pi) max(w/pi)]); ylim([-1 1]);
title({'';'Phase of X(e^{jw}) vs w/\pi'}); grid;

% From the plots, we observe that X(e^jω) is periodic in ω (period 2*pi)
% but is not conjugate-symmetric.

