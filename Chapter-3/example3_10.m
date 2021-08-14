% [Chp 3 Section 3.2 Page 71]
%
%  EXAMPLE 3.10
%  
%  To verify the conjugation property (3.8), let x[n] be a complex-valued 
%  random sequence over −5 ≤ n ≤ 10 with real and imaginary parts uniformly 
%  distributed between [0, 1]. The MATLAB verification is as follows.
%

% >>>>> solution <<<<<

n = -5:10;
x = rand(1, length(n)) + 1i*rand(1, length(n));     % complex sequence

k = -100:100;
w = (pi/100)*k;                                     % w = [-pi, pi]

% dtft{x[n]} = X(e^jw)
Xw =  x * exp(-1i * pi/100 * n' * k);

% y[n] = conjugate of x[n]
y = conj(x);

% dtft{y[n]} = Y(e^jw)
Yw =  y * exp(-1i * pi/100 * n' * k);

% [conjugation property test]

% Y(w) should be equal to conjugate of X(-w)
Yw_expected = conj(fliplr(Xw));                     % fliplr reverses X(w)

% check error
error = max(abs(Yw - Yw_expected))

if (error < 10e-14)
    disp(['Since the maximum absolute error between the two Fourier transform arrays', ... 
        ' is less than 10^−14, the two arrays are identical within the limited', ...
        ' numerical precision of MATLAB.']);
    disp('Property Verfified.');
end

