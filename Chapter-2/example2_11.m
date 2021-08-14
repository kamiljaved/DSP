% [Chp 2 Section 2.4 Page 48]
%
%  EXAMPLE 2.11
%  
%  Consider the following difference equation:
%               y[n] − y[n − 1] + 0.9y[n − 2] = x[n]; ∀n
%  a. Calculate and plot the impulse response h[n] at n = −20,..., 100.
%  b. Calculate and plot the unit step response s[n] at n = −20,..., 100.
%  c. Is the system specified by h[n] stable?

% the coefficients in the given equation are
a = [1 -1 0.9];
b = [1];

% (a) impulse response is computed using impz(b, a, n)
n = -20:100;
h = impz(b, a, n);
% plot
subplot(2, 1, 1); 
stem(n, h, 'filled', 'MarkerSize', 3);
xlabel('n'); ylabel('h[n]');
title('Impulse Response'); 

% (b) step response is computed using filter(b, a, x) with x=u[n]
[x, n] = stepseq(0, -20, 100);
y = filter(b, a, x);
% plot
subplot(2, 1, 2); 
stem(n, y, 'filled', 'MarkerSize', 3);
xlabel('n'); ylabel('y[n]');
title('Step Response'); 

% (c) LTI system is stable if h[n] is absolutely summable
% so need to compute h[n] for all n
% plot of the impulse response shows that h[n] is practically zero for n>100
% sum of |h(n)| for all n, is given by
h_sum = sum(abs(h))                 % finite, so system is stable
% or, can check roots of characteristic equation
z = roots(a); 
magz = abs(z)                       % system is stable if |roots| < 1

