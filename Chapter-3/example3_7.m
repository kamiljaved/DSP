% [Chp 3 Section 3.2 Page 69]
%
%  EXAMPLE 3.7
%  
%  In this example, we will verify the linearity property (3.5) using 
%  real-valued finite-duration sequences. Let x1[n] and x2[n] be two random 
%  sequences uniformly distributed between [0, 1] over 0 ≤ n ≤ 10. Then we 
%  can use our numerical discrete-time Fourier transform procedure as follows.
%

% >>>>> solution <<<<<

n = 0:10;
x1 = rand(1, length(n));
x2 = rand(1, length(n));

alpha = 2;
beta = 3;

M = 500;
k = 0:M; 
w = (pi/M)*k;

% dtft{x1[n]} = X1(e^jw)
X1w =  x1 * exp(-1i * pi/M * n' * k);
% dtft{x2[n]} = X2(e^jw)
X2w =  x2 * exp(-1i * pi/M * n' * k);

% linear combination of x1[n] and x2[n]
x3 = alpha*x1 + beta*x2;

% dtft{x3[n]} = X3(e^jw)
X3w = x3 * (exp(-1i * pi/M * n' * k));

% [linearity test]

% linear combination of X1w and X2w (should be equal to X3w)
X1w_X2w = alpha*X1w + beta*X2w;

% check error
error = max(abs(X3w - X1w_X2w))

if (error < 10e-14)
    disp(['Since the maximum absolute error between the two Fourier transform arrays', ... 
        ' is less than 10^−14, the two arrays are identical within the limited', ...
        ' numerical precision of MATLAB.']);
    disp('Property Verfified.');
end

