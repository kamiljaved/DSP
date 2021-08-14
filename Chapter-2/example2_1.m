% [Chp 2 Section 2.1 Page 28]
%
%  EXAMPLE 2.1 
%
%  Generate and plot each of the following sequences over the indicated interval.
%  a. x(n) = 2δ(n + 2) − δ(n − 4), −5 ≤ n ≤ 5.
%  b. x(n) = n[u(n)−u(n−10)]+10e^[−0.3(n−10)][u(n−10)−u(n−20)], 0 ≤ n ≤ 20.
%  c. x(n) = cos(0.04πn)+0.2w(n), 0 ≤ n ≤ 50, 
%     where w(n) is a Gaussian random sequence with zero mean and unit variance.
%  d. x˜(n) = {..., 5, 4, 3, 2, 1, 5, 4, 3, 2, 1, 5, 4, 3, 2, 1, ...}; −10 ≤ n ≤ 9.
%                                 ↑

% (a)
n = -5:5;
x = 2*impseq(-2, -5, 5) - impseq(4, -5, 5);
subplot(2, 2, 1);
stem(n, x);
xlabel('n'); ylabel('x[n]');
title('Sequence in Exercise 2.1a');

% (b)
n = 0:20;
x = n.*(stepseq(0, 0, 20)-stepseq(10, 0, 20)) + 10*exp(-0.3*(n-10)).*(stepseq(10, 0, 20)-stepseq(20, 0, 20));
subplot(2, 2, 3);
stem(n, x);
xlabel('n'); ylabel('x[n]');
title('Sequence in Exercise 2.1b');

% (c)
n = 0:50;
x = cos(0.04*pi*n)+0.2*randn(size(n));
subplot(2, 2, 2);
stem(n, x); xlim([min(n) max(n)]);
xlabel('n'); ylabel('x[n]');
title('Sequence in Exercise 2.1c');

% (d)
n = -10:9;
P = 4;
x = [5, 4, 3, 2, 1];
xtilde = x' * ones(1, P);
xtilde = xtilde(:)';
subplot(2, 2, 4);
stem(n, xtilde);
xlabel('n'); ylabel('xtilde[n]');
title('Sequence in Exercise 2.1d');

