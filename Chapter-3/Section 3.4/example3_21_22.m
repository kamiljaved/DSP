% [Chp 3 Section 3.4 Page 92]
%
%  EXAMPLE 3.21
%  
%  From the samples x1[n] in Example 3.19a, reconstruct xa(t) and 
%  comment on the results.
%
%  EXAMPLE 3.22
%  
%  From the samples x2[n] in Example 3.19b, reconstruct xa(t) and 
%  comment on the results.

% >>>>> solution <<<<<

% define DT signal x1[n]
Fs1 = 5000;                         % samples/second
Ts1 = 1/Fs1;
n1 = -25:1:25; 
x1 = exp(-1000*abs(n1*Ts1));

% analog signal reconstruction from x1[n]
dt = 5e-5; 
t1 = -0.005:dt:0.005;
xa1 = x1 * sinc(Fs1*(ones(length(n1),1)*t1 - (n1*Ts1)'*ones(1,length(t1))));
error = max(abs(xa1 - exp(-1000*abs(t1))))

% define DT signal x2[n]
Fs2 = 1000;                         % samples/second
Ts2 = 1/Fs2;
n2 = -25:1:25; 
x2 = exp(-1000*abs(n2*Ts2));

% analog signal reconstruction from x2[n]
dt = 5e-5;
t2 = -0.005:dt:0.005;
xa2 = x2 * sinc(Fs2*(ones(length(n2),1)*t2 - (n2*Ts2)'*ones(1,length(t2))));
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
title('Reconstructed Signal from x_1[n]    Using the sinc Function');
subplot(2, 1, 2);
hold on;
    plot(t2*1000, xa2, 'LineWidth', 1.5);
    stem(n2*Ts2*1000, x2, 'filled', 'MarkerSize', 4, 'LineStyle','none');  
hold off;
xlabel('t   (ms)'); ylabel('Amplitude'); 
xlim([-5 5]); ylim([-0.1 1.1]);
title({'';'Reconstructed Signal from x_2[n]    Using the sinc Function'});
