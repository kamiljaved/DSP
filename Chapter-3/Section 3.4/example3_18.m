% [Chp 3 Section 3.4 Page 84]
%
%  EXAMPLE 3.18
%  
%  Let xa(t) = e^−1000|t|. Determine and plot its Fourier transform.
%

% >>>>> solution <<<<<

% through analysis, Xa(jΩ) = 0.002/(1+(Ω/1000)^2)
% consider that Xa(jΩ) ≈ 0 for Ω ≥ 2π(2000), hence Fo ≈ 2000 Hz
% select ∆t = 5×10^-5 << 1/2(Fo) = 1/2(2000) = 25×10^-5

% define analog (CT) signal xa(t)
dt = 5e-5;
t = -0.005:dt:0.005;
xa = exp(-1000*abs(t));

% CTFT Xa(jΩ)of xa(t)
Wmax = 2*pi*2000;                   % Fo ≈ 2000 Hz
W = 0:Wmax/500:Wmax;                % calculating only for positive W
Xa = xa * exp(-1i*t'*W) * dt; 
Xa = real(Xa);

% since xa(t) is real, Real{Xa(jΩ)} will be even
W = [-fliplr(W(2:end)) W];          % Ω from -Wmax to Wmax
Xa = [fliplr(Xa(2:end)) Xa];        % Xa(jΩ) over [-Wmax, Wmax]

% plot xa(t), and Xa(jΩ) over [-Wmax, Wmax]
subplot(2, 1, 1);
plot(t*1000, xa);
xlabel('t   (ms)'); ylabel('Amplitude');
title('Analog Signal   x_a(t)');
subplot(2, 1, 2);
plot(W/(2*pi*1000), Xa*1000);
xlabel('Frequency   (kHz)'); ylabel('Amplitude\times1000');
title({'';'Continuous-Time Fourier Transform   X_a(e^{j\Omega})'});
