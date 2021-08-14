% [Chp 2 Section 2.1 Page 27]

% function: Implements y[n] = x[-n]

% <syntax>
% [y,n] = sigfold(x,n)

function [y,n] = sigfold(x, n)

% fliplr(A) returns A with its columns flipped in the left-right direction (that is, about a vertical axis).
y = fliplr(x);      % flip about vert. axis (datapoint values remain same)
n = -fliplr(n);     % flip about vert. axis (the n axis needs to be negated as well)

% e.g. if n = -3:5                 i.e.        -3 -2 -1 0 1 2 3 4 5
% then flipped n should be = -5:3  i.e.  -5 -4 -3 -2 -1 0 1 2 3

end