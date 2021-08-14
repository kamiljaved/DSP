% [Chp 3 Section 3.2 Page 70]
%
%  EXAMPLE 3.9
%  
%  To verify the frequency shift property (3.7), we will use the graphical approach.
%  Let
%       x[n] = cos(πn/2), 0 ≤ n ≤ 100 and y[n] = e^{jπn/4}.x[n]
%  i.e. 
%       Y(w) = X(w) with frequency shift of pi/4
%

% >>>>> solution <<<<<

n = 0:100;
x = cos(pi*n/2);

k = -100:100; 
w = (pi/100)*k;                                     % w = [-pi, pi]

% dtft{x[n]} = X(e^jw)
Xw =  x * exp(-1i * pi/100 * n' * k);

% expected y[n] for frequency shift of pi/4 in X(w)
w0 = pi/4;
y = x.*exp(1i*w0*n);

% dtft{y[n]} = Y(e^jw)
Yw =  y * exp(-1i * pi/100 * n' * k);

% [frequency shifting property test (graphical)]
fig = figure;

% [mag. and phase] of X(w)
subplot(2, 2, 1);
plot(w/pi, abs(Xw));
xlabel('Frequency in \pi units (w/\pi)');
ylabel('|X(e^{jw})|');
title('Magnitude of X(e^{jw}) vs w/\pi'); grid;
subplot(2, 2, 2);
plot(w/pi, angle(Xw));
xlabel('Frequency in \pi units (w/\pi)');
ylabel('∠X(e^{jw})   (radians)');
title('Phase of X(e^{jw}) vs w/\pi'); grid;

% [mag. and phase] of Y(w)
subplot(2, 2, 3);
plot(w/pi, abs(Yw));
xlabel('Frequency in \pi units (w/\pi)');
ylabel('|Y(e^{jw})|');
title({'';'Magnitude of Y(e^{jw}) vs w/\pi'}); grid;
subplot(2, 2, 4);
plot(w/pi, angle(Yw));
xlabel('Frequency in \pi units (w/\pi)');
ylabel('∠Y(e^{jw})   (radians)');
title({'';'Phase of Y(e^{jw}) vs w/\pi'}); grid;

% From the plots, we observe that X(ejω) is indeed shifted by π/4
% in both magnitude and angle.

