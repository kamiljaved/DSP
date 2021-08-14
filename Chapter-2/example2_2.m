% [Chp 2 Section 2.1 Page 30]
%
%  EXAMPLE 2.2 
%
%  Let x(n) = {1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1}. 
%                   ↑
%  Determine and plot the following sequences.
%  a. x1(n) = 2x(n − 5) − 3x(n + 4)
%  b. x2(n) = x(3 − n) + x(n) x(n − 2)
%

% The sequence x(n) is nonzero over −2 ≤ n ≤ 10.
n = -2:10;
x = [1:7 6:-1:1];

% (a)
[x1a, n1a] = sigshift(x, n, 5);
[x1b, n1b] = sigshift(x, n, -4);
[x1, n1] = sigadd(2*x1a, n1a, -3*x1b, n1b);
subplot(2, 1, 1);
stem(n1, x1); 
xlim([min(n1) max(n1)]);
xlabel('n'); ylabel('x1[n]');
title('Sequence in Example 2.2a');

% (b)
% x2(n) = x(3 − n) + x(n) x(n − 2)
%       = x(-(n-3)) + x(n)x(n-2)
[x2a, n2a] = sigfold(x, n);
[x2a, n2a] = sigshift(x2a, n2a, 3);
[x2b, n2b] = sigshift(x, n, 2);
[x2b, n2b] = sigmult(x, n, x2b, n2b);
[x2, n2] = sigadd(x2a, n2a, x2b, n2b);
subplot(2, 1, 2);
stem(n2, x2); 
xlim([min(n2) max(n2)]);
xlabel('n'); ylabel('x2[n]');
title('Sequence in Example 2.2b');


