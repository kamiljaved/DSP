% [Chp 3 Section 3.4 Page 95]
%
%  EXAMPLE 3.24
%  
%  From the samples x1[n] and x2[n] in Example 3.19, reconstruct xa(t) 
%  using the spline function. Comment on the results.

% >>>>> solution <<<<<

% define DT signal x1[n]
Fs1 = 5000;                         % samples/second
Ts1 = 1/Fs1;
n1 = -25:1:25; 
x1 = exp(-1000*abs(n1*Ts1));

% analog signal reconstruction from x1[n]
dt = 5e-5; 
t1 = -0.005:dt:0.005;
xa1 = spline(n1*Ts1, x1, t1);
error = max(abs(xa1 - exp(-1000*abs(t1))))

% define DT signal x2[n]
Fs2 = 1000;                         % samples/second
Ts2 = 1/Fs2;
n2 = -25:1:25; 
x2 = exp(-1000*abs(n2*Ts2));

% analog signal reconstruction from x2[n]
dt = 5e-5;
t2 = -0.005:dt:0.005;
xa2 = spline(n2*Ts2, x2, t2);
error = max(abs(xa2 - exp(-1000*abs(t2))))

% plot resconstructed signal, from x1[n] and x2[n]
figure;
subplot(2, 1, 1);
hold on;
    plot(t1*1000, xa1, 'LineWidth', 1.5);
    stem(n1*Ts1*1000, x1, 'filled', 'MarkerSize', 4, 'LineStyle','none');  
hold off;
xlabel('t   (ms)'); ylabel('Amplitude'); 
xlim([-5 5]); ylim([-0.1 1.1]);
title('Reconstructed Signal from x_1[n]    Using Cubic Spline Function');
subplot(2, 1, 2);
hold on;
    plot(t2*1000, xa2, 'LineWidth', 1.5);
    stem(n2*Ts2*1000, x2, 'filled', 'MarkerSize', 4, 'LineStyle','none');  
hold off;
xlabel('t   (ms)'); ylabel('Amplitude'); 
xlim([-5 5]); ylim([-0.1 1.1]);
title({'';'Reconstructed Signal from x_2[n]    Using Cubic Spline Function'});
