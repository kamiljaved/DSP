% [Chp 4 Section 4.4 Page 126]
%
%  EXAMPLE 4.13
%  
%  A causal LTI system is described by the following difference equation:
%           y[n] = 0.81y[n−2] + x[n] − x[n−2]
%  Determine
%  a. the system function H(z),
%  b. the unit impulse response h[n],
%  c. the unit step response v[n], that is, the response to unit step u[n]
%  d. the frequency response function H(e^jω), 
%     and plot its magnitude and phase over 0 ≤ ω ≤ π.
%

% >>>>> solution <<<<<

% (a)

% take z-transform of both sides of the difference equation 
% and solve for H(z) = Y(z)/X(z), we have
%           H(z) = (1 − z^−2) / (1 − 0.81z^−2 )
%                = (1 − z^−2) / ((1 + 0.9z^−1)(1 − 0.9z^−1)), |z| > 0.9

% (b)

% impulse response h[n]

% b's and a's in poly frac H(z) = B(z)/A(z) (power 0 onwards) are,
b = [1 0 -1];
a = [1 0 -0.81];

% compute partial fraction form
[R, p, C] = residuez(b, a)

% which gives
%           H(z) = 1.2346 − 0.1173*1/(1 + 0.9z^−1) 
%                         − 0.1173*1/(1 − 0.9z^−1) , |z| > 0.9
% inverse z-transform is
%           h[n] = 1.2346δ[n] − 0.1173{1+(−1)^n} (0.9)^n u[n]

% (c)

% unit step response
%           V(z) = H(z) U(z)
%                = H(z) (1 / (1 − z^−1)) , |z| > 0.9 ∩ |z| > 1
%                =    1.0556*(1 / (1 − 0.9z^−1)) 
%                   − 0.0556*(1 / (1 + 0.9z^−1)) , |z| > 0.9
% inverse z-transform is
%           v[n] = [1.0556(0.9)^n − 0.0556(−0.9)^n] u[n]

% (d)

% compute frequency response H(e^jw)
%           H(e^jω) = (1 − e−j^2ω) / (1 − 0.81e^−j2ω)
w = [0:1:500]*pi/500; 
Hw = freqz(b, a, w);

% obtain mag. and phase of H(w)
Hw_mag = abs(Hw);
Hw_ang = angle(Hw);

% plot the freq. response
fig = figure;
subplot(2, 1, 1);
plot(w/pi, Hw_mag);
title('Magnitude Response |H(e^{jw})|'); 
ylabel('Magnitude'); grid;
subplot(2,1,2);
plot(w/pi, Hw_ang/pi);
xlabel('Frequency in \pi units (w/\pi)');
ylabel('Phase in \pi Units'); grid;
title('Phase Response ∠H(e^{jw})')
