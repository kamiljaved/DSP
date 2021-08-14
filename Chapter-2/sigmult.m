% [Chp 2 Section 2.1 Page 26]

% function: Implements y(n) = x1[n]*x2[n], for different sized x1 and x2

% <syntax>
% [y, n] = sigmult(x1, n1, x2, n2)
% <I/O>
% y = product sequence over n, which includes n1 and n2
% x1 = first sequence over n1
% x2 = second sequence over n2 (n2 can be different from n1)

function [y, n] = sigadd(x1, n1, x2, n2)

% n should be from min(n1, n2) to max(n1, n2)
n = min(min(n1), min(n2)) : max(max(n1), max(n2));
% for storing x1 and x2 in array spanning length of y
x1_ = zeros(1, length(n)); x2_ = x1_;
% copy x1 into x1_ at its corresponding n values (from n1)
x1_( find( (n>=min(n1)) & (n<=max(n1)) == 1 ) ) = x1;
% copy x2 into x2_ at its corresponding n values (from n2)
x2_( find( (n>=min(n2)) & (n<=max(n2)) == 1 ) ) = x2;

% take dot product of the two signals
y = x1_ .* x2_;

end
