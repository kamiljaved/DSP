% [Chp 3 Section 3.3 Page 75]
%
%  EXAMPLE 3.13
%  
%  Determine the frequency response H(ejω) of a system characterized by, 
%           h[n] = (0.9)^n u[n] 
%  Plot the magnitude and the phase responses.
%

% >>>>> solution <<<<<

% analyzing the DTFT formula, resultant H(e^jw) equation is,
%           H(e^jw) = 1 / (1 - 0.9e^-jw)
%                   = e^jw / (e^jw - 0.9)

w = 0:pi/500:pi;                            % w = [0, pi] (501 values)

% dtft{h[n]} = H(e^jw) = e^jw / (e^jw - 0.9)
Hw =  exp(1i*w) ./ (exp(1i*w) - 0.9);

% obtain mag., phase of H(w)
Hw_mag = abs(Hw);
Hw_ang = angle(Hw);

% plot the mag. and phase of H(w)
fig = figure;
subplot(2, 1, 1);
plot(w/pi, Hw_mag);
xlabel('Frequency in \pi units (w/\pi)');
ylabel('|H(e^{jw})|');
title('Magnitude of H(e^{jw}) vs w/\pi     (Magnitude Response)');
subplot(2, 1, 2);
plot(w/pi, Hw_ang/pi);
xlabel('Frequency in \pi units (w/\pi)');
ylabel('∠H(e^{jw})   (radians/\pi)');
title({'';'Phase of H(e^{jw}) vs w/\pi     (Phase Response)'});

