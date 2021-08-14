% [Chp 2 Section 2.1 Page 35]
% 
%  EXAMPLE 2.4 
%  
%  Let x(n) = u(n) − u(n − 10). 
%  Decompose x(n) into even and odd components.
%

n = 0:10;
x = stepseq(0, 0, 10) - stepseq(10, 0, 10);

[xe, xo, m] = evenodd(x, n);

subplot(2, 2, 1);
stem(n, x); 
title('Rectangular Pulse');
xlabel('n'); ylabel('x[n]'); 
axis([-10, 10, 0, 1.2])

subplot(2, 2, 2); 
stem(m, xe); 
title('Even Part')
xlabel('n'); ylabel('x_e[n]'); 
axis([-10, 10, 0, 1.2])

subplot(2, 2, 4); 
stem(m, xo); 
title('Odd Part')
xlabel('n'); ylabel('x_o[n]'); 
axis([-10, 10, -0.6, 0.6])

