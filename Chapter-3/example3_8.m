% [Chp 3 Section 3.2 Page 70]
%
%  EXAMPLE 3.8
%  
%  Let x(n) be a random sequence uniformly distributed between [0, 1] over 
%  0 ≤ n ≤ 10, and let y(n) = x(n − 2). Then we can verify the sample 
%  shift property (3.6) as follows.
%

% >>>>> solution <<<<<

n = 0:10;
x = rand(1, length(n));

M = 500;
k = 0:M; 
w = (pi/M)*k;

% dtft{x[n]} = X(e^jw)
Xw =  x * exp(-1i * pi/M * n' * k);

% shifted signal y[n] = x[n-2]
y = x;
ny = n+2;

% dtft{y[n]} = Y(e^jw)
Yw =  y * exp(-1i * pi/M * ny' * k);

% [sample shifting property test]

% Y(w) should be equal to X(w).e^{-jwk} (where k=2)
Yw_expected = Xw.*exp(-1i*w*2);

% check error
error = max(abs(Yw - Yw_expected))

if (error < 10e-14)
    disp(['Since the maximum absolute error between the two Fourier transform arrays', ... 
        ' is less than 10^−14, the two arrays are identical within the limited', ...
        ' numerical precision of MATLAB.']);
    disp('Property Verfified.');
end

