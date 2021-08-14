% [Chp 3 Section 3.4 Page 85]
%
%  EXAMPLE 3.19
%  
%  Let xa(t) = e^−1000|t| (from Example 3.18).
%  To study the effect of sampling on the frequency-domain quantities, 
%  we will sample xa(t) at two different sampling frequencies.
%  
%  a. Sample xa(t) at Fs = 5000 samples/sec to obtain x1[n]. 
%     Determine and plot X1(e^jω).
%  b. Sample xa(t) at Fs = 1000 samples/sec to obtain x2[n]. 
%     Determine and plot X2(e^jω).

% >>>>> solution <<<<<

% define analog (CT) signal xa(t)
dt = 5e-5;
t = -0.005:dt:0.005;
xa = exp(-1000*abs(t));

% (a) 
% Fs = 5000 samples/sec
% BW of xa(t) ≈ 2kHz  ==>  Nyquist rate ≈ 4000 samples/sec
% Fs > 2(2000)=4000 samples/sec  ==>  Aliasing will be ~nonexistent

% define DT signal xa[n]
Fs = 5000;                          % samples/second
Ts = 1/Fs;
n = -25:1:25; 
x = exp(-1000*abs(n*Ts));

% DTFT Xa(jω)of xa[n]
w = 0:pi/500:pi;                    % calculating only for w = [0, pi]
Xw = x * exp(-1i*n'*w); 
Xw = real(Xw);

% since xa[n] is real, Real{Xa(jω)} will be even
w = [-fliplr(w(2:end)) w];          % w from -pi to pi
Xw = [fliplr(Xw(2:end)) Xw];        % Xa(jω) over [-pi, pi]

% plot sampled xa(t), and Xa(jω) over [-pi, pi]
% using function provided at end of this script
plotSampSigDTFT_ex3_19(t, xa, n, x, Ts, w, Xw);

% (b) 
% Fs = 1000 samples/sec
% BW of xa(t) ≈ 2kHz  ==>  Nyquist rate ≈ 4000 samples/sec
% Fs < 2(2000)=4000 samples/sec  ==>  Significant aliasing will occur

% define DT signal xa[n]
Fs = 1000;                          % samples/second
Ts = 1/Fs;
n = -25:1:25; 
x = exp(-1000*abs(n*Ts));

% DTFT Xa(jω)of xa[n]
w = 0:pi/500:pi;                    % calculating only for w = [0, pi]
Xw = x * exp(-1i*n'*w); 
Xw = real(Xw);

% since xa[n] is real, Real{Xa(jω)} will be even
w = [-fliplr(w(2:end)) w];          % w from -pi to pi
Xw = [fliplr(Xw(2:end)) Xw];        % Xa(jω) over [-pi, pi]

% plot sampled xa(t), and Xa(jω) over [-pi, pi]
% using function provided at end of this script
plotSampSigDTFT_ex3_19(t, xa, n, x, Ts, w, Xw);


% ------------
% Function to plot sampled (real) xa(t) & DTFTs [-pi, pi] in 2x1 subplot
% ------------
function plotSampSigDTFT_ex3_19(t, xa, n, x, Ts, w, Xw)
    figure;
    subplot(2, 1, 1);
    hold on;
        plot(t*1000, xa, '--');
        stem(n*Ts*1000, x, 'filled', 'MarkerSize', 3);  
    hold off;
    i = find(t==0, 1);
    text(t(i)+0.5, xa(i)-0.15, ['Ts = ', num2str(Ts*1000), ' ms']);
    xlabel('t   (ms)'); ylabel('Amplitude'); xlim([-5 5]);
    title('Discrete Signal   x_a[n]');
    subplot(2, 1, 2);
    plot(w/pi, Xw);
    xlabel('’Frequency in \pi Units   (w/\pi)'); ylabel('Amplitude');
    ylim([0 max(Xw)]);
    title({'';'Discrete-Time Fourier Transform   X_a(e^{j\omega})'});
end
