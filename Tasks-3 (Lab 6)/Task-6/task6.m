% TASK-6 (Lab 6) assigned on 17/05/2021
% [Chp 4 Section 4.6 Page 138] (PROBLEM 4.20)

% ------------
% A stable system has four zeros and four poles as given below.
%           zeros: ± 1, ±j1         Poles: ± 0.9, ±j0.9
% It is also known that the frequency response function H(ejω) evaluated at ω = π/4 
% is equal to 1, that is,
%           H(e^jπ/4) = 1
% ------------

% >>> confirmation of some paperwork using MATLAB <<<

% ------------
% (Q1)
% ------------
%  Determine the system function H(z), and indicate its region of convergence.
% ------------

% define H(z)
syms z k;
zeros = [1 -1 1i -1i];                     % zeros in H(z)
poles = [0.9 -0.9 1i*0.9 -1i*0.9];          % poles in H(z)
Hz = k * prod(z-zeros) / prod(z-poles);

% detrermining K, given H(e^jπ/4) = 1
Hw = subs(Hz, z, exp(1i*pi/4)) == 1;
K = vpa(solve(Hw, k))

% so complete H(z) is,
Hz = subs(Hz, k, K)
Hz = vpa(expand(Hz))

% pole-zero map
fig = figure;
zplane(zeros.', poles.');
title('Pole-Zero Map of given system');

% ------------
% (Q3 & Q4)
% ------------
% Determine steady-state response yss[n] and the transient response ytr[n] 
% if the input is x[n] = cos(πn/4)u[n].
% ------------

% determining the partial fraction form, and the inverse, of Y(z)

% define Y(z) = H(z)X(z) in terms of z^-1 (using paperwork equation)
syms z;
N = 0.82805*(1-z^-4)*(1-1/sqrt(2)*z^-1);            % numerator of Y(z)
D = ((1-0.6561*z^-4)*(1-sqrt(2)*z^-1+z^-2));        % denominator of Y(z)
Yz = N / D;
Yz = expand(Yz);

% find the CCDE coefficients of Y(z)
[b, a] = get_zsys_coeffs(N, D);

% check if the coefficients are correct against factorized Y(z)
Yz2 = sum(b.*z.^-(0:(length(b)-1)))/sum(a.*z.^-(0:(length(a)-1)));
Yz2 = expand(Yz2);
isequal(Yz, Yz2)

% determine the partial fraction form of Y(z)
[r, p, k] = residuez(double(b), double(a))

% display partial fraction sum symbolically
p = round(p, 4); r = round(r, 4); k = round(k, 4);
Yz = sum(r./(1-p*z^-1));
if ~isempty(k)
    Yz = Yz + sum(k.*z.^-(0:(length(k)-1)));
end
Yz = vpa(Yz, 5)
