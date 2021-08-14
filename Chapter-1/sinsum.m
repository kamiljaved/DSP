% [Chp 1 Section 1.2 Page 14]

% example of a function

function xt = sinsum(t, ck)
% Computes sum of sinusoidal terms of the form in (1.1)
% x = sinsum(t, ck)
%

K = length(ck);
k = 1:K;

% force ck & t to be row vectors
ck = ck(:)'; 
t = t(:)';     

xt = ck*sin(2*pi*k'*t);

end