% [Assignment No. 4]   Z-Transform
% Reg. No. :   2016-EE-189

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%    TASK 1    %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%

% >>> task <<< compute inverse Z-transform of H(z)

% define sampling frequency Fs and corresponding w0
Fs = 11025;
w0 = 2000*pi/Fs;

% [method 1] using iztrans()

% define H(z) symbolically
syms z;
syms w_0;
Hz = vpa((1-2*cos(w_0)*(z^-1)+(z^-2))/(1+0.5*(z^-1)))

% compute inverse Z-transform of H(z) using iztrans()
% <syntax> f = iztrans(F, transVar)
h = vpa(iztrans(Hz))

% substitute w0 value to get numerical sequence h[n]
h = vpa(subs(h, {w_0}, {w0}), 5)

% save h[n] expression as function-handle for later use
func_h = matlabFunction(h)

% [method 2] using residuez() (partial fraction decomposition)

% b's and a's in poly. frac H(z)=B(z)/A(z) are,
b = [1 -2*cos(w0) 1];
a = [1 0.5];

% compute partial fraction form of H(z) using residuez()
% <syntax> [r, p, k] = residuez(b, a)
[R, p, C] = residuez(b, a)

% display partial fraction sum symbolically
Hz = sum(R./(1-p*z^-1));
if ~isempty(C)
    Hz = Hz + sum(C.*z.^-(0:length(C)-1));
end
Hz = vpa(Hz, 5)

% >>> task <<< plot all poles and zeros of H(z) in z-plane

% coefficients (b's and a's) in poly. frac H(z)=B(z)/A(z) are,
b = [1 -2*cos(w0) 1];
a = [1 0.5];

% plot pole-zero map of H(z) using zplane() with b's and a's from H(z)=B(z)/A(z)
% <syntax> zplane(b, a)
zplane(b, a);
title({'Pole-Zero Plot of H(z) in z-plane';''});

% >>> task <<< plot DTFT H(e^jw) using expression derived on paper

% initialize frequency vector for computing freq. resp. H(w)
w = -2*pi:0.01:2*pi;

% compute freq. resp. H(w) using derived equation eq. (VI) on paper
Hw = 2*exp(-1i*w) - (4*cos(w0)+4) + (4*cos(w0)+5)./(1+0.5*exp(-1i*w));

% obtain magnitude and phase of freq. resp. H(w)
Hw_mag = abs(Hw);                           % get the magnitude of H(w)
Hw_ang = angle(Hw)*180/pi;                  % get the phase (angle) of H(w) in degrees
 
% obtain real and imaginary parts of freq. resp. H(w)
Hw_real = real(Hw);                         % get the real part of H(w)
Hw_imag = imag(Hw);                         % get the imaginary part of H(w)
 
% plot magnitude and phase of freq. resp. H(w), 
% and also its real and imaginary parts
fig = figure; set(fig,'Units','normalized','Position',[0 0 1 1.6]); 

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

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%    TASK 2    %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%

% >>> function <<< following "get_zsys_coeffs()" funtion is present in included "get_zsys_coeffs.m" file

% <function>
% computes system CCDE coefficients (b's and a's) from the system
% Z-domain frequency response expression H(z).
%
% <syntax>
% [b, a] = get_zsys_coeffs(Hz)
%
% <I/O>
% b = M+1 coefficients { b0, b1, ..., bM } for { x[0], x[-1], ..., x[-M] }
% a = N+1 coefficients { a0, a1, ..., aN } for { y[0], y[-1], ..., y[-N] }
% Hz = system H(z) expression (type 'sym') of form B(z)/A(z) 
%    = (b0 + b1.z^-1 + ..... + bM.z^-M)/(a0 + a1.z^-1 + ..... + aN.z^-N)
% 
% function [b, a] = get_zsys_coeffs(Hz)
%     
%     % Hz must not contain any other symvars besides 'z'
%     syms z;
%     if ~isequal(symvar(Hz), z)
%         error("Only H(z) expressions with single default symvar 'z' are acceptable");
%     end
%     
%     % NOTE:
%     % Hz must be of form B(z)/A(z) 
%     %    = (b0 + b1.z^-1 + ..... + bM.z^-M)/(a0 + a1.z^-1 + ..... + aN.z^-N)
%     % for the following method to work
%     
%     syms repl;                      % replacement symvar
%     
%     % replace z^-1 with replacement var 'repl' 
%     % to keep its degree consistent in the next step
%     H2 = subs(Hz, z^-1, repl);
%     
%     % separate numerator and denominator polynomials
%     [N, D] = numden(H2);
%     
%     % extract coefficients b's and a's
%     b = coeffs(N);
%     a = coeffs(D);
%     
%     % normalize the coefficients
%     a = a./a(1);
%     b = b./b(1);
%     
% end

% >>> function <<< following "get_sys_imp_resp()" funtion is present in included "get_sys_imp_resp.m" file

% <function>
% computes system impulse response h[n] for 0 <= n <= P using get_system_out(),
% given symbolic H(z) or numeric {b, a} CCDE coefficients, x (for n>=0),
% and initial conditions (N aux y values, M initial x values).
%
% <syntax>
% [h, nh] = get_sys_imp_resp(Hz|{b,a}, P)
% [h, nh] = get_sys_imp_resp(Hz|{b,a}, P, N_aux, M_init)
%
% <I/O>
% h = filter impulse resp. { h[-N], h[-N+1], ..., h[-1], h[0], h[1], ..., h[P] }
% Hz = system H(z) expression (type 'sym') of form B(z)/A(z) 
%    = (b0 + b1.z^-1 + ..... + bM.z^-M)/(a0 + a1.z^-1 + ..... + aN.z^-N)
% {b, a} = system CCDE coefficients (type 'cell' of size [1,2])
% N_aux = N auxiliary y values { y[-1], y[-2], ...., y[-N] }
% M_init = M initial x values { x[-1], x[-2], ...., x[-M] }
% 
% function [h, nh] = get_sys_imp_resp(Hz, P, N_aux, M_init)
% 
%     % acceptable number of inputs
%     if ~any([2 4] == nargin)
%         error('Wrong Number of Input Arguments. Allowed: 2, 4.');
%     end
%     
%     % check whether H(z) or the {b, a} coefficients are provided
%     % in either case, extract the coefficients (b's and a's)
%     if and(isequal(class(Hz), 'cell'), isequal(size(Hz), [1,2]))
%         b = Hz{1};
%         a = Hz{2};
%     elseif isequal(class(Hz), 'sym')
%         [b, a] = get_zsys_coeffs(Hz)
%     else
%         error("H(z) must either be a sym exp. or a cell of size 1x2");
%     end
%     
%     % if initial conditions not provided, assume zero i.c. (rest)
%     if (nargin == 2)
%         N_aux = zeros(1, length(a)-1);
%         M_init = zeros(1, length(b)-1);
%     end
% 
%     % generate input sequence x[n] = impluse of length P+1
%     % <syntax> [x, n] = impseq(n0, n1, n2) where n1 <= n0 <= n2
%     [delta, n] = impseq(0, 0, P);
%     
%     % compute the impulse response h[n] using get_system_out()
%     [h, nh] = get_system_out(b, a, delta, N_aux, M_init);
%     
%     % plot the impulse response h[n] of the system
%     figure;
%     stem(nh, h, 'filled', 'MarkerSize', 4);
%     xlabel('n'); ylabel('h[n]'); 
%     xlim([0 length(delta)]);
%     title({'Impulse Response h[n] of given system';''});
%     
% end

% >>> task <<< plot impulse response h[n] of sys. respresented by given H(z)

% define sampling frequency Fs and corresponding w0
Fs = 11025;
w0 = 2000*pi/Fs;

% define system H(z) symbolically
syms z;
syms w_0;
Hz = vpa((1-2*cos(w_0)*(z^-1)+(z^-2))/(1+0.5*(z^-1)));

% substitute w0 value to get H(z) only in terms of z
Hz = vpa(subs(Hz, {w_0}, {w0}), 5)

% call get_sys_imp_resp() with above expression Hz to get/plot its impulse resp. h[n]
% <syntax> [h, nh] = get_sys_imp_resp(Hz, P)
[h, nh] = get_sys_imp_resp(Hz, 12);

% >>> task <<< compare this impulse response h[n] with inverse Z-tranform
% expression (h[n]) of H(z) found using iztrans(), for n>=0

% truncate above calculated h[n] to start at n=0
h = h(find(nh==0):end); 
nh = nh(find(nh==0):end);

% call h[n] expression function-handle stored in func_h() to directly compute
% some h[n] values from inverse Z-transform of H(z)
h2 = func_h(nh);

% will return 1 if both h[n] are equal
isequal(round(h, 10), round(h2, 10))

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%    TASK 3    %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%

% >>> task <<< read and play the provided almostcaught.wav file
% in MATLAB using the sound command, with Fs = 11025 samples/second

% define sampling frequency Fs and corresponding w0
Fs = 11025;
w0 = 2000*pi/Fs;

% read audio data from almostcaught.wav file
[x, Fs] = audioread('almostcaught.wav');
duration = (length(x)-1)/Fs;

% get and play the audio x(t) using sound command, using above Fs
sound(x, Fs);
% pause execution while the sound is playing
pause(duration);

% >>> task <<< plot DTFT of sound data before passing through system (DTFT of x[n])

% initialize frequency vector for computing DTFT X(w)
w = -pi:2*pi/(length(x)-1):pi;              % for higher/proper DTFT resolution
f = Fs * w/(2*pi);                          % corresponding cont. domain frequencies
x = x.';                                    % convert x[n] to row-vector

% NOTE:
% ------------------
% Since the sound data x[n] is quite large, much higher frequency (w) resolution 
% is needed for DTFT, to properly identify any tones. This requires some 
% consideration in the method by which DTFT is computed, discussed below.
% ------------------
% (1) Matrix-multiplication method,
%               Xw = x * exp(-1i * n' * w);
%     cannot be used since the matrix n'*w will be too large to store in memory.
% ------------------
% (2) For-Loop method,
%               Xw = zeros(1, length(w));
%               for i = 1:length(w)
%                   Xw(i) = x *  exp(-1i * w(i) * n');
%               end
%     cannot be used since it will be quite slow due to many values of w.
% ------------------
% (3) Instead, use the MATLAB in-built function fftshift(x) to first compute 
%     the DFT of x[n] (using FFT algorithm), and then use fftshift(dft) to 
%     transform this DFT to DTFT of x[n], as follows,
%               Xw = fftshift(fft(x));
%     This is the method used below for DTFT computation.
% ------------------

% compute DTFT X(w) using fft() and fftshift()
Xw = fftshift(fft(x));

% obtain magnitude and phase of DTFT X(w)
Xw_mag = abs(Xw);                           % get the magnitude of X(w)
Xw_ang = angle(Xw)*180/pi;                  % get the phase (angle) of X(w) in degrees

% plot magnitude and phase of DTFT X(w)
fig = figure; set(fig,'Units','normalized','Position',[0 0 1.4 1]);

% plot magnitude of X(w) vs w
subplot(1, 2, 1);
plot(w, Xw_mag);
xlabel('w   (radians/sample)'); ylabel('|X(e^{jw})|');
title({'Magnitude of X(e^{jw}) vs w';''}, 'FontSize', 16);
setDTFTradialAxis(1); ax = gca; ax.FontSize = 16;

% plot phase of X(w) vs w
subplot(1, 2, 2);
plot(w, Xw_ang);
xlabel('w   (radians/sample)'); ylabel('∠X(e^{jw})   (degrees)');
title({'Phase of X(e^{jw}) vs w';''}, 'FontSize', 16);
setDTFTradialAxis(1); ax = gca; ax.FontSize = 16;

% plot magnitude of X(w) vs continuous-domain frequencies f
fig = figure;
plot(f, Xw_mag);
xlabel('f   (Hz)'); ylabel('|X(e^{jw})|');
xlim([min(f) max(f)]); xticks([min(f) -3000:2000:3000 max(f)]);
title({'Magnitude of X(e^{jw}) vs Continuous-Domain Frequencies f';''});

% >>> task <<< pass the sound data through given system, using get_system_out(),
% with the system CCDE coefficients stated in methodology section

% b's and a's in poly. frac H(z)=B(z)/A(z) are (as shown in methodology section),
b = [1 -2*cos(w0) 1];
a = [1 0.5];

% assuming zero initial conditions (rest)
N_aux = zeros(1, length(a)-1);
M_init = zeros(1, length(b)-1);

% compute system output y[n] for 0 <= n < length(x), with input = sound data x[n],
% using get_system_out()
[y, ny] = get_system_out(b, a, x, N_aux, M_init);
duration = (length(y)-1)/Fs;

% get and play the audio y(t) using sound command, using given Fs
sound(y, Fs);
% pause execution while the sound is playing
pause(duration);

% >>> task <<< plot DTFT of sound data after passing through system (DTFT of y[n])

% initialize frequency vector for computing DTFT Y(w)
w = -pi:2*pi/(length(y)-1):pi;              % for higher/proper DTFT resolution
f = Fs * w/(2*pi);                          % corresponding cont. domain frequencies

% compute DTFT Y(w) using fft() and fftshift()
Yw = fftshift(fft(y));

% obtain magnitude and phase of DTFT Y(w)
Yw_mag = abs(Yw);                           % get the magnitude of Y(w)
Yw_ang = angle(Yw)*180/pi;                  % get the phase (angle) of Y(w) in degrees

% plot magnitude and phase of DTFT Y(w)
fig = figure; set(fig,'Units','normalized','Position',[0 0 1.4 1]);

% plot magnitude of Y(w) vs w
subplot(1, 2, 1);
plot(w, Yw_mag);
xlabel('w   (radians/sample)'); ylabel('|Y(e^{jw})|'); 
ylim([0 100]);
title({'Magnitude of Y(e^{jw}) vs w';''}, 'FontSize', 16);
setDTFTradialAxis(1); 
ax = gca; ax.FontSize = 16;

% plot phase of Y(w) vs w
subplot(1, 2, 2);
plot(w, Yw_ang);
xlabel('w   (radians/sample)'); ylabel('∠Y(e^{jw})   (degrees)');
title({'Phase of Y(e^{jw}) vs w';''}, 'FontSize', 16);
setDTFTradialAxis(1); 
ax = gca; ax.FontSize = 16;

% plot magnitude of Y(w) vs continuous-domain frequencies f
fig = figure;
plot(f, Yw_mag);
xlabel('f   (Hz)'); ylabel('|Y(e^{jw})|');
xlim([min(f) max(f)]); xticks([min(f) -3000:2000:3000 max(f)]); ylim([0 100]);
title({'Magnitude of Y(e^{jw}) vs Continuous-Domain Frequencies f';''});

%%%%%    EOF    %%%%%