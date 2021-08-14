% [Chp 2 Section 2.4 Page 50]
%
%  EXAMPLE 2.12
%  
%  Let us consider the convolution given in Example 2.7. 
%  The input sequence is of finite duration
%               x[n] = u[n] − u[n − 10]
%  while the impulse response is of infinite duration
%               h[n] = [0.9]n u[n]
%  Determine y[n] = x[n] ∗ h[n].

% represent the LTI system given by h[n] into a CCDE
%       h[n] - (0.9)h[n-1] = δ[n]
% substitute x[n] for δ[n], and y[n] for h[n]
%       y[n] - (0.9)y[n-1] = x[n]

% compute y[n] = x[n] ∗ h[n] using filter(b, a, x)
b = [1];
a = [1 -0.9];
n = -5:50;
x = stepseq(0, -5, 50) - stepseq(10, -5, 50);      % take difference directly by making them same-sized
y = filter(b, a, x);

% plot y[n]
stem(n, y, 'filled', 'MarkerSize', 3); 
xlabel('n'); ylabel('y[n]'); 
title('Output Sequence   y[n] = x[n] ∗ h[n]')
xlim([min(n) max(n)]);
ylim([min(y) max(y)*2]);

%  not all infinite-length impulse responses can be converted into difference equations
