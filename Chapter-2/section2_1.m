% Code Snippets from Section 2.1

%%%% (2.1) %%%%
% DISCRETE-TIME SIGNALS


% representation of x[n] using row vectors n and x
n = [-3, -2, -1, 0, 1, 2, 3, 4];
x = [2, 1, -1, 0, 1, 4, 3, 7];


% >>> TYPES OF SEQUENCES <<<

% unit sample sequence
% TEST FUNCTION [x, n] = impseq(n0, n1, n2)
[x, n] = impseq(2, -4, 4);
stem(n, x);
[x, n] = impseq(-2, -6, -1);
stem(n, x);

% unit step sequence
% TEST FUNCTION [x, n] = stepseq(n0, n1, n2)
[x, n] = stepseq(0, -10, 10);
stem(n, x);

% real-valued exponential sequence
n = [0:1000];
a = 0.995;
x = a.^n;
stem(n, x);

% complex valued exponential sequence
n = [0:10];
a = 2;
w0 = 3;
x = exp((a + 1i*w0)*n);
stem(n, abs(x));

% sinusoidal sequence
% e.g. x(n) = 3 cos(0.1πn + π/3) + 2 sin(0.5πn)
n = [0:10];
x = 3*cos(0.1*pi*n + pi/3) + 2*sin(0.5*pi*n);
stem (n, x);

% random sequences
N = 50;
x = rand(1, N);     % (length N) elements uniformly distributed between [0, 1]
x = randn(1, N);    % (length N) Gaussian random sequence with mean 0 and variance 1
stem(x);

% periodic sequence
x = [1:100];
P = 5;
xtilde = x' * ones(1, P);
xtilde = xtilde(:)';
stem(xtilde);


% >>>  OPERATIONS ON SEQUENCES <<<

% signal addition
% TEST FUNCTION [y, n] = sigadd(x1, n1, x2, n2)
n1 = [-10:-1];
x1 = 0.9.^n1;
n2 = [0:10];
x2 = n2;
[y, n] = sigadd(x1, n1, x2, n2);
stem(n, y);

% signal multiplication (sample by sample / dot multiplication)
% TEST FUNCTION [y, n] = sigmult(x1, n1, x2, n2)
[y, n] = sigmult(x1, n1, x2, n2);
stem(n, y);

[y, n] = sigadd(x1, n1, x2, n2);

% scaling
a = 5;      % scalar value
y = a*y;

% shifting 
% TEST FUNCTION [y, n] = sigshift(x, m, k)
[y, n] = sigshift(y, n, 5);
stem(n, y);

% folding / time-reversal
[y, n] = sigfold(y, n);
stem(n, y);

% sample summation
s = sum(y)

% sample products
p = prod(y)

% signal energy
% = sum of square of all elements
% or sum of prod of element with its conjugate
ex = sum(y.*conj(y))
ex = sum(abs(y).^2)

% signal power
% avg power of periodic signal xtilde[n] with period of N
% = (1/N)*sum(abs( xtilde(0:N-1) ).^2) 
% i.e. sum of abs. square over one period divided by N

% examples done in example files

% DT sinusoids

% decompose real signal into even and odd parts
% TEST FUNCTION [xe, xo, m] = evenodd(x, n)
[ye, yo, n] = evenodd(y, n);
subplot(1, 2, 1);
stem(n, ye);
subplot(1, 2, 2);
stem(n, yo);


