% [Chp 4 Section 4.4 Page 121]
%
%  EXAMPLE 4.11
%  
%  Consider a causal system
%           y[n] = 0.9y[n − 1] + x[n]
%  a. Determine H(z) and sketch its pole-zero plot.
%  b. Plot |H(e^jω)| and ∠H(e^jω).
%  c. Determine the impulse response h[n].
%

% >>>>> solution <<<<<

% (a)

% H(z) = 1/(1−0.9z^−1) ; |z| > 0.9 since the system is causal. 
% There is one pole at 0.9 and one zero at the origin.

b = [1 0];              % specify b=[1,0] instead of b=1 because the zplane 
                        % function assumes that scalars are zeros or poles.
a = [1 -0.9]; 

% plot pole-zero map
fig = figure;
zplane(b, a)
 
% (b)

% compute H(e^jw) using freqz
% for 0 <= w <= 0.99*pi
% [Hw, w] = freqz(b, a, 100);
% for 0 <= w <= pi
% [Hw, w] = freqz(b, a, 200, 'whole');  
% Hw = Hw(1:101); w = w(1:101);
% or
w = [0:1:100]*pi/100; 
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

% (c)

% using z-transform pairs (Table 4.1)
%           h[n] = Z-INV{ 1/(1−0.9z^−1) } ; |z| > 0.9
%                = (0.9)^n u[n]
