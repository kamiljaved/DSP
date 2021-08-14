% TASK-1 (Lab 6) assigned on 17/05/2021
% [Chp 2 Section 2.5 Page 54] (PROBLEM 2.7)

% ------------
% (Q2)
% ------------
% Decompose the sequence
%           x[n] = 10 exp([−0.1 + j0.2π]n) , 0 ≤ n ≤ 10
% into its conjugate-symmetric and conjugate-antisymmetric components. 
% Plot their real and imaginary parts to verify the decomposition.
% ------------

% define the sequence x[n]
n = 0:10;
x = 10*exp((-0.1 + 1i*0.2*pi)*n);

% obtain CS (xe[n]) and CAS (xo[n]) parts of x[n]
[xe, xo, m] = evenodd(x, n);

% plot real and imaginary parts of CS & CAS decomposition
fig = figure; set(fig,'Units','normalized','Position',[0 0 1 1.6]);

% plot real and imaginary parts of CS xe[n]
subplot(2, 2, 1);
stem(m, real(xe), 'filled', 'MarkerSize', 3);
xlabel('n');
ylabel('Real\{ x_e[n] \}');
title({'Real Part of CS x_e[n]';''});
subplot(2, 2, 2);
stem(m, imag(xe), 'filled', 'MarkerSize', 3);
xlabel('n');
ylabel('Imag\{ x_e[n] \}');
title({'Imaginary Part of CS x_e[n]';''});

% plot real and imaginary parts of CAS xo[n]
subplot(2, 2, 3);
stem(m, real(xo), 'filled', 'MarkerSize', 3);
xlabel('n');
ylabel('Real\{ x_o[n] \}');
title({'Real Part of CAS x_o[n]';''});
subplot(2, 2, 4);
stem(m, imag(xo), 'filled', 'MarkerSize', 3);
xlabel('n');
ylabel('Imag\{ x_o[n] \}');
title({'Imaginary Part of CAS x_o[n]';''});
