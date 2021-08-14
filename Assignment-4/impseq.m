% [Chp 2 Section 2.1 Page 23]

% function to generate x[n] = delta[n-n0]; n1 <= n <= n2

% <syntax>
% [x, n] = impseq(n0, n1, n2)

function [x, n] = impseq(n0, n1, n2)

n = [n1:n2];        % size n2-n1+1
%x = [(n-n0)==0];    % size = size(n), 1 at n=n0
x = [n==n0];        % size = size(n), 1 at n=n0

end