% <function>
% (updated) computes system CCDE coefficients (b's and a's) from the system
% Z-domain frequency response expression H(z).
%
% <syntax>
% [b, a] = get_zsys_coeffs(Hz)
%
% <I/O>
% b = M+1 coefficients { b0, b1, ..., bM } for { x[0], x[-1], ..., x[-M] }
% a = N+1 coefficients { a0, a1, ..., aN } for { y[0], y[-1], ..., y[-N] }
% Hz = system H(z) expression (type 'sym') of form B(z)/A(z) 
%    = (b0 + b1.z^-1 + ..... + bM.z^-M)/(a0 + a1.z^-1 + ..... + aN.z^-N)

function [b, a] = get_zsys_coeffs(num, den)

    % NOTE:
    % Hz must be of form B(z)/A(z) 
    %    = (b0 + b1.z^-1 + ..... + bM.z^-M)/(a0 + a1.z^-1 + ..... + aN.z^-N)
    % for the following method to work
    % else, provide seperate numerator and denominator expressions
    
    syms z repl;                        % z and replacement symvar
    if nargin == 1
        
        Hz = num;
        
        % Hz must not contain any other symvars besides 'z'
        if ~isequal(symvar(Hz), z)
            error("Only H(z) expressions with single default symvar 'z' are acceptable");
        end
        
        % replace z^-1 with replacement var 'repl' 
        % to keep its degree consistent in the next step
        H2 = subs(Hz, z^-1, repl);

        % separate numerator and denominator polynomials
        [N, D] = numden(H2);
    
    elseif nargin == 2
        
        % Numerator/Denominator must not contain any other symvars besides 'z'
        if or(~isequal(symvar(num), z), ~isequal(symvar(den), z))
            error("Only B(z)/A(z) expressions with single default symvar 'z' are acceptable");
        end
        
        % replace z^-1 with replacement var 'repl' 
        N = subs(num, z^-1, repl);
        D = subs(den, z^-1, repl);
        
    end
    
    % extract coefficients b's and a's
    b = fliplr(coeffs(N, 'All'));
    a = fliplr(coeffs(D, 'All'));
    
    % normalize the coefficients
    a = a./a(1);
    b = b./a(1);
    
end
