% [Chp 4 Section 4.3 Page 115]
%
%  EXAMPLE 4.8
%  
%  To verify our residue calculations, let us consider the rational function
%           X(z) = z / (3z^2 − 4z + 1)
%  given in Example 4.7
%

% >>>>> solution <<<<<

% First, rearrange X(z) so that it is a function in ascending powers of z^−1 (0 onwards):
%           X(z) = z^−1 / (3 − 4z^−1 + z^−2) 
%                = 0z^0 + z^−1 / (3z^0 − 4z^−1 + z^−2)

% so b's and a's in poly frac X(z) = B(z)/A(z) are,
b = [0 1];
a = [3 -4 1];

% compute partial fraction form
[R, p, C] = residuez(b, a)

% display symbolically
syms z;
X = sum(R./(1-p*z^-1))
if ~isempty(C)
    X = X + sum(C.*z.^-(0:length(C)-1))
end

% convert back to the rational function form
[b, a] = residuez(R, p, C)

% display symbolically
X = sum(b.*z.^-(0:length(b)-1)) / sum(a.*z.^-(0:length(a)-1))
