% [Chp 3 Section 3.4 Page 94]
%
%  EXAMPLE 3.23
%  
%  Plot the reconstructed signal from the samples x1[n] in Example 3.19 
%  using the ZOH and the FOH interpolations. Comment on the plots.

% >>>>> solution <<<<<

% define DT signal x1[n]
Fs = 5000;                          % samples/second
Ts = 1/Fs;
n = -25:1:25; 
x = exp(-1000*abs(n*Ts));

% plot resconstructed signal, from x1[n] and x2[n]
figure;
subplot(2, 1, 1);
hold on;
    stairs(n*Ts*1000, x, 'LineWidth', 1.5);
    stem(n*Ts*1000, x, 'filled', 'MarkerSize', 3, 'LineStyle','none');  
hold off;
xlabel('t   (ms)'); ylabel('Amplitude'); 
xlim([-5 5]); ylim([-0.1 1.1]);
title('Reconstructed Signal from x_1[n]    Using ZOH');
subplot(2, 1, 2);
hold on;
    plot(n*Ts*1000, x, 'LineWidth', 1.5);
    stem(n*Ts*1000, x, 'filled', 'MarkerSize', 3, 'LineStyle','none');  
hold off;
xlabel('t   (ms)'); ylabel('Amplitude'); 
xlim([-5 5]); ylim([-0.1 1.1]);
title({'';'Reconstructed Signal from x_1[n]    Using FOH'});
