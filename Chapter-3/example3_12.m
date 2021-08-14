% [Chp 3 Section 3.2 Page 72]
%
%  EXAMPLE 3.12
%  
%  In this problem, we verify the symmetry property (3.10) of real signals. 
%  Let
%           x[n] = sin(πn/2), −5 ≤ n ≤ 10
%  Then, using the evenodd function developed in Chapter 2, we can compute
%  the even and odd parts of x[n] and then evaluate their discrete-time 
%  Fourier transforms.
%  We will provide the numerical as well as graphical verification.
%

% >>>>> solution <<<<<

n = -5:10;
x = sin(pi*n/2);

k = -100:100;
w = (pi/100)*k;                             % w = [-pi, pi]

% dtft{x[n]} = X(e^jw)
Xw =  x * exp(-1i * pi/100 * n' * k);

% [test: symmetry property of real signals]

% decompose signal into even and odd parts,
% using evenodd() function (file: evenodd.m)
[xe, xo, m] = evenodd(x, n);

% dtft{xe[n]} = XE(e^jw)
XEw =  xe * exp(-1i * pi/100 * m' * k);

% dtft{xo[n]} = XO(e^jw)
XOw =  xo * exp(-1i * pi/100 * m' * k);

% get real (XR) and imaginary (XR) parts of X(w)
XRw = real(Xw);
XIw = imag(Xw);

% for real x[n]:

% even part of X(w) (i.e. XEw) should be equal to real part of X(w) (i.e. XRw)
error1 = max(abs(XEw-XRw));

% odd part of X(w) (i.e. XOw) should be equal to j times imaginary part of X(w) (i.e. j*XIw)
error2 = max(abs(XOw-1i*XIw));

if and(error1 < 10e-14, error2 < 10e-14)
    disp('Property Verified');
end

% graphical verification
fig = figure;

subplot(2 ,2, 1); 
plot(w/pi, XRw); 
grid; axis([-1,1,-2,2])
ylabel('Real\{ X(e^{jw}) \}');
title('Real Part of X(e^{jw})');

subplot(2, 2, 3); 
plot(w/pi, real(XEw)); 
grid; axis([-1,1,-2,2])
xlabel('Frequency in \pi units (w/\pi)'); ylabel('Real\{ XE(e^{jw}) \}');
title('DTFT of x_e[n]   (Real Part)')

subplot(2, 2, 2); 
plot(w/pi, XIw); 
grid; axis([-1,1,-10,10])
ylabel('Imag\{ X(e^{jw}) \}');
title('Imaginary Part of X(e^{jw})');

subplot(2 ,2, 4); 
plot(w/pi, imag(XOw)); 
grid; axis([-1,1,-10,10])
xlabel('Frequency in \pi units (w/\pi)'); ylabel('Imag\{ XO(e^{jw}) \}')
title('DTFT of x_o[n]   (Imaginary Part)')

% From the plots, we observe that the real part of X(e^jω) 
% [or the imaginary part of X(e^jω)] is equal to the DTFT 
% of xe[n] [or xo[n]].

