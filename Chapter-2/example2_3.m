% [Chp 2 Section 2.1 Page 31]
% 
%  EXAMPLE 2.3 
%
%  Generate the complex-valued signal
%  x[n] = e^[(−0.1+j0.3)n], −10 ≤ n ≤ 10
%  and plot its magnitude, its phase, its real part, and its imaginary part in four separate subplots.
%

n = -10:10;
x = exp((-0.1+1i*0.3)*n);

subplot(2, 2, 1);
stem(n, real(x)); 
xlim([min(n) max(n)]); xlabel('n'); ylabel('Amplitude');
title('Real Part of x[n]');

subplot(2, 2, 2);
stem(n, imag(x)); 
xlim([min(n) max(n)]); xlabel('n'); ylabel('Amplitude');
title('Imaginary Part of x[n]');

subplot(2, 2, 3);
stem(n, abs(x)); 
xlim([min(n) max(n)]); xlabel('n'); ylabel('|x[n]|   (magnitude)');
title('Magnitude of x[n]');

subplot(2, 2, 4);
stem(n, angle(x)*180/pi); 
xlim([min(n) max(n)]); xlabel('n'); ylabel('∠x[n]   (degrees)');
title('Phase of x[n]');

