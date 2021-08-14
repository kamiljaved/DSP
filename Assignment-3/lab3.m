% [Assignment No. 3]   Properties of Linear Time-Invariant Systems
% Reg. No. :   2016-EE-189

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%    TASK 1    %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%

% following "get_system_out" funtion is present in included "get_system_out.m" file

% <function>
% computes system output y for 0 <= n < len(x) using CCDE (forward) recurrence formula,
% given b, a, x (for n>=0), and initial conditions (N aux y values, M initial x values).
% assumes x[n] starts at n=0.
%
% <syntax>
% [y, ny] = get_system_out(b, a, x, N_aux, M_init)
%
% <I/O>
% y = filter output { y[-N], y[-N+1], ..., y[-1], y[0], y[1], ..., y[len(x)-1] }
% b = M+1 coefficients { b0, b1, ..., bM } for { x[0], x[-1], ..., x[-M] }
% a = N+1 coefficients { a0, a1, ..., aN } for { y[0], y[-1], ..., y[-N] }
% N_aux = N auxiliary y values { y[-1], y[-2], ...., y[-N] }
% M_init = M initial x values { x[-1], x[-2], ...., x[-M] }
%
% function [y, ny] = get_system_out(b, a, x, N_aux, M_init)
%     
%     % basic testing of inputs
%     if ~((length(N_aux)+1)==length(a)) 
%         error('Length of "a" should Length of "N_aux" + 1'); 
%     elseif ~((length(M_init)+1)==length(b)) 
%         error('Length of "b" should Length of "M_init" + 1');
%     end
% 
%     % setup y and x for forward recursive computation, and other variables
%     y = [wrev(N_aux) zeros(1, length(x))];
%     x2 = [wrev(M_init) x];
%     N = length(N_aux);
%     M = length(M_init);
%     ny = -N:length(x)-1;
%     
%     % starting indexes for x and y -> x[0] and y[0]
%     ix = N + 1;
%     iy = M + 1;
%     
%     % compute y[n] for n=0 to n=len(x)-1 
%     for i = 0:length(x)-1
%         
%         % (mult. with bM:b0 and) sum n-M to n-0 values of x (here, n=ix)
%         x_sum = x2(ix-M:ix) * wrev(b)';
%         
%         % (mult. with aN:a1 and) sum n-N to n-1 values of y (here, n=iy)
%         y_sum = y(iy-N:iy-1) * wrev(a(2:end));
%         
%         % compute current y value (at n=iy) (here, a(1) = a0)
%         y(iy) = (-y_sum + x_sum) / a(1);
%         
%         ix = ix + 1;
%         iy = iy + 1;
%     end
% end

% >>> task <<< implement echo system, for input = lab-2 voice rec. (15s), using get_system_out()

% read audio data from lab2.wav file (x[n]=0 for n<0)
[x, Fs] = audioread('lab2.wav');

% convert x to single-channel audio (mono) to use echo filter
x = x(:,1)';

% initialize variables corresponding to CCDE of echo system (LTI Causal)
b = [1 -1 zeros(1, 22050-2) 1 -1];         % = { b0, b1, ..., b22050, b22051 }
a = [1, -1];                               % = { a0, a1 }
N_aux = [0];                               % = { y[-1] }
M_init = zeros(1, 22051);                  % = { x[-1], x[-2], ..., x[-22050], x[-22051] }

% compute y[n] for 0 <= n < length(x)
% since this is a large computation, avoid repeating it if already computed
% load("lab3_y.mat");
% if or(~exist('y','var'), ~exist('ny', 'var'))
    [y, ny] = get_system_out(b, a, x, N_aux, M_init);
    save("lab3_y.mat",'y', 'ny');
% end

% plot x[n] and y[n]
fig = figure; set(fig,'Units','normalized','Position',[0 0 1.4 .9]);  

% plot x[n]
subplot(1, 2, 1);
stem(x, 'filled', 'MarkerSize', 1);
xlabel('n'); ylabel('x[n]'); 
xlim([0 length(x)]); ylim([min(y) max(y)]); ax = gca; ax.FontSize = 13;
title({'x[n]   (Unfiltered Audio)';''}, 'FontSize', 14);

% plot y[n]
subplot(1, 2, 2);
stem(ny, y, 'filled', 'MarkerSize', 1);
xlabel('n'); ylabel('y[n]'); 
xlim([0 max(ny)]); ylim([min(y) max(y)]); ax = gca; ax.FontSize = 13;
title({'y[n]   (Echo System Output: audio with echo)';''}, 'FontSize', 14);

% get and play echo-signal y(t) using sound command
sound(y, Fs);

% >>> task <<< Question (2) testing linearity for y[-1]=3

% initialize variables corresponding to CCDE of new system (with y[-1]=3)
b = [1 -1 zeros(1, 22050-2) 1 -1];         % = { b0, b1, ..., b22050, b22051 }
a = [1, -1];                               % = { a0, a1 }
N_aux = [3];                               % = { y[-1] }
M_init = zeros(1, 22051);                  % = { x[-1], x[-2], ..., x[-22050], x[-22051] }

% initialize two inputs x1[n] & x2[n], and A & B
nx = 0:500;
x1 = sin(.002*nx);
x2 = sin(.05*nx);
A = 5;
B = 10;

% compute A.y1[n]+B.y2[n]
[y1, ny1] = get_system_out(b, a, x1, N_aux, M_init);
[y2, ny2] = get_system_out(b, a, x2, N_aux, M_init);
a_y1_plus_b_y2 = A*y1 + B*y2;

% compute y3[n] = T[A.x1[n]+B.x2[n]]
x3 = A*x1 + B*x2;
[y3, ny3] = get_system_out(b, a, x3, N_aux, M_init);

% plot A.y1[n]+B.y2[n] and y3[n] = T[A.x1[n]+B.x2[n]]
fig = figure; set(fig,'Units','normalized','Position',[0 0 1.4 .9]); 

% plot A.y1[n]+B.y2[n]
subplot(1, 2, 1);
stem(ny1, a_y1_plus_b_y2, 'filled', 'MarkerSize', 3);
xlabel('n'); ylabel('Ay_1+By_2'); 
xlim([min(ny1) max(ny1)]); ax = gca; ax.FontSize = 13;
title({'A.y_1[n] + B.y_2[n]';''}, 'FontSize', 14);

% plot y3[n] = T[A.x1[n]+B.x2[n]]
subplot(1, 2, 2);
stem(ny3, y3, 'filled', 'MarkerSize', 3);
xlabel('n'); ylabel('y_3 = T[Ax_1+Bx_2]'); 
xlim([min(ny3) max(ny3)]); ax = gca; ax.FontSize = 13;
title({'y_3[n]  =  T [ A.x_1[n] + B.x_2[n] ]';''}, 'FontSize', 14);

% numerically comparing outputs A.y1[n]+B.y2[n] and y3[n] = T[A.x1[n]+B.x2[n]]
isequal(a_y1_plus_b_y2, y3)                % returns 0 if not equal

% answer: system is non-linear for y[-1]=3

% >>> task <<< Question (3) impulse response of system for y[-1]=0

% reset initial conditions to rest for LTI Causal system (i.e. y[-1]=0)
N_aux = [0];                               % = { y[-1] }

% initialize input x[n] = delta[n]
n = 0:22050*3;
delta = [1 zeros(1, length(n)-1)];         % = 1 only for n=0

% compute y[n]=h[n] (impulse response) of system for 0 <= n < length(x)
[h, nh] = get_system_out(b, a, delta, N_aux, M_init);

% plot impulse response h[n] of system
fig = figure;
stem(nh, h, 'filled', 'MarkerSize', 4);
xlabel('n'); ylabel('h[n]'); 
xlim([0 length(delta)]);
title({'Impulse Response h[n] of echo system';''});

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%    TASK 2    %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%

% >>> task <<< compute frequency response for system with given h[n]

% initialize variables for the rectangular pulse h[n]
n = 0:4;                                   % define vector n from 0 to 4
h = ones(1, length(n));                    % h[n] = [1, 1, 1, 1, 1] (for n=0:4)

% initialize variables for computing freq. resp. of h[n]
w = -2*pi:0.01:2*pi;

% compute freq. resp. of h[n] using stated equation 
% with help of matrix-multiplication on the vectors h, n, and w
Hw = h * exp(-1i * n' * w);

% obtain magnitude and phase of freq. resp. H(w)
Hw_mag = abs(Hw);                          % get the magnitude of H(w)
Hw_ang = angle(Hw)*180/pi;                 % get the phase (angle) of H(w)
                                           % (in degrees)
                                                
% obtain real and imaginary parts of freq. resp. H(w)
Hw_real = real(Hw);                        % get the real part of H(w)
Hw_imag = imag(Hw);                        % get the imaginary part of H(w)
                                                
% plot magnitude and phase of freq. resp. H(w), 
% and also its real and imaginary parts
fig = figure; set(fig,'Units','normalized','Position',[0 0 1 1.4]); 

% plot magnitude of H(w) vs w
subplot(2, 2, 1);
plot(w, Hw_mag);
xlabel('w   (radians/sample)');
ylabel('|H(e^{jw})|');
title({'Magnitude of H(e^{jw}) vs w';''});
setDTFTradialAxis()

% plot phase of H(w) vs w
subplot(2, 2, 2);
plot(w, Hw_ang);
xlabel('w   (radians/sample)');
ylabel('∠H(e^{jw})   (degrees)');
title({'Phase of H(e^{jw}) vs w';''});
setDTFTradialAxis()

% plot real part of H(w) vs w
subplot(2, 2, 3);
plot(w, Hw_real);
xlabel('w   (radians/sample)');
ylabel('Real\{ H(e^{jw}) \}');
title({'';'Real Part of H(e^{jw}) vs w';''});
setDTFTradialAxis()

% plot imaginary part of H(w) vs w
subplot(2, 2, 4);
plot(w, Hw_imag);
xlabel('w   (radians/sample)');
ylabel('Imag\{ H(e^{jw}) \}');
title({'';'Imaginary Part of H(e^{jw}) vs w';''});
setDTFTradialAxis()

% >>> task <<< compute freqency response using equations derived on paper

% initialize frequency vector for freq. resp. of h[n]
w = -2*pi:0.01:2*pi;
  
% compute magnitude of freq. resp. |H(w)| using derived equation
Hw_mag_EQ = sqrt((sin(2.5*w) ./ sin(0.5*w)).^2);    % to keep values positive

% compute phase of freq. resp. ∠H(w) using derived equation
Hw_ang_EQ = atan2(sin(5*w),(1-cos(5*w))) - atan2(sin(w),(1-cos(w)));
Hw_ang_EQ = Hw_ang_EQ*180/pi;                       % convert to degrees

% plot magnitude and phase of freq. resp. H(w), found using derived equations
fig = figure; set(fig,'Units','normalized','Position',[0 0 1 .55]); 

% plot magnitude of H(w) vs w
subplot(1, 2, 1);
plot(w, Hw_mag_EQ);
xlabel('w   (radians/sample)');
ylabel('|H(e^{jw})|');
ax = gca; ax.FontSize = 13;
title({'Magnitude of H(e^{jw}) vs w   (using derived equation)';''}, 'FontSize', 14);
setDTFTradialAxis()

% plot phase of H(w) vs w
subplot(1, 2, 2);
plot(w, Hw_ang_EQ);
xlabel('w   (radians/sample)');
ylabel('∠H(e^{jw})   (degrees)');
ax = gca; ax.FontSize = 13;
title({'Phase of H(e^{jw}) vs w   (using derived equation)';''}, 'FontSize', 14);
setDTFTradialAxis()
