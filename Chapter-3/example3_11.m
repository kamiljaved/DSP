% [Chp 3 Section 3.2 Page 72]
%
%  EXAMPLE 3.11
%  
%  To verify the folding property (3.9), let x(n) be a random sequence 
%  over −5 ≤ n ≤ 10 uniformly distributed between [0, 1]. 
%  The MATLAB verification is as follows.
%

% >>>>> solution <<<<<

n = -5:10;
x = rand(1, length(n));                     % random sequence

k = -100:100;
w = (pi/100)*k;                             % w = [-pi, pi]

% dtft{x[n]} = X(e^jw)
Xw =  x * exp(-1i * pi/100 * n' * k);

% y[n] = time-reversed version of x[n] i.e. x[-n]
y = fliplr(x);
ny = -fliplr(n);

% dtft{y[n]} = Y(e^jw)
Yw =  y * exp(-1i * pi/100 * ny' * k);

% [folding property test]

% Y(w) should be equal to frequency-reversed of X(w) i.e. X(-w)
Yw_expected = fliplr(Xw);                   % fliplr reverses X(w)

% check error
error = max(abs(Yw - Yw_expected))

if (error < 10e-14)
    disp(['Since the maximum absolute error between the two Fourier transform arrays', ... 
        ' is less than 10^−14, the two arrays are identical within the limited', ...
        ' numerical precision of MATLAB.']);
end

% equivalently
if isequal(round(Yw, 10), round(Yw_expected, 10))
    disp('Property Verfified.');
end

