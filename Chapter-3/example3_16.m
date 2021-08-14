% [Chp 3 Section 3.3 Page 79]
%
%  EXAMPLE 3.16
%  
%  A 3rd-order lowpass filter is described by the difference equation,
%       y[n] = 0.0181 x[n] + 0.0543 x[n−1] + 0.0543 x[n−2] + 0.0181 x[n−3]
%              + 1.76 y[n−1] − 1.1829 y[n−2] + 0.2781 y[n−3]
%  Plot the magnitude and the phase response of this filter, 
%  and verify that it is a lowpass filter.
%

% >>>>> solution <<<<<

% implement the ccde to find H(e^jw)

% filter coefficients
b = [0.0181  0.0543 0.0543  0.0181];            % b = {b0, b1, b2, b3}
a = [1.0000 -1.7600 1.1829 -0.27810];           % a = {a0, a1, a2, a3}

% arrays m and l for sum in num. and den. respectively
m = 0:length(b)-1;
l = 0:length(a)-1;

K = 500; 
k = 0:1:K;
w = pi*k/K;                                     % = [0, pi] with K+1 points

% calculate H(e^jw) using ccde coefficients
Hw = (b * exp(-1i * m' * w)) ./ (a * exp(-1i * l' * w));

% equivalently:
% l2 = 1:length(a)-1;
% a2 = a(2:end);
% Hw = (b * exp(-1i * m' * w)) ./ (1 + a2 * exp(-1i * l2' * w));

% obtain mag., phase of H(w)
Hw_mag = abs(Hw);
Hw_ang = angle(Hw);

% plot the mag. and phase of H(w)
fig = figure;
subplot(2, 1, 1);
plot(w/pi, Hw_mag);
xlabel('Frequency in \pi units (w/\pi)'); 
ylabel('|H(e^{jw})|'); grid;
title('Magnitude of H(e^{jw}) vs w/\pi     (Magnitude Response)');
subplot(2, 1, 2);
plot(w/pi, Hw_ang/pi);
xlabel('Frequency in \pi units (w/\pi)'); 
ylabel('∠H(e^{jw})   (radians/\pi)'); grid;
title({'';'Phase of H(e^{jw}) vs w/\pi     (Phase Response)'});

% From the plots, we see that the filter is indeed a lowpass filter
% i.e. centered at zero-frequency.

