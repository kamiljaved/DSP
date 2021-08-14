% [Chp 3 Section 3.3 Page 77]
%
%  EXAMPLE 3.15
%  
%  An LTI system is specified by the difference equation
%           y[n] = 0.8y[n−1] + x[n]
%  a. Determine H(e^jω).
%  b. Calculate and plot the steady-state response yss[n] to
%           x[n] = cos(0.05πn)u[n]
%

% >>>>> solution <<<<<

% Rewrite the difference equation as,
%           y[n] − 0.8y[n − 1] = x[n]
% (a) 
%           H(e^jω) = 1 / (1 − 0.8e^−jω)
% (b) 
% In the steady state, the input is x(n) = cos(0.05πn) with 
% frequency ω0 = 0.05π and θ0 = 0◦. The response of the system is
%           H(e^j0.05π) = 1 / (1 − 0.8e^−j0.05π) = 4.0928e^−j0.5377
% Therefore,
%           yss(n) = 4.0928 cos(0.05πn − 0.5377) 
%                  = 4.0928 cos[0.05π(n − 3.42)]
% This means that at the output the sinusoid is scaled by 4.0928 
% and shifted by 3.42 sampling intervals. 
% This can be verified using MATLAB, as follows:

% input x[n]
n = 0:100;
x = cos(0.05*pi*n);

% compute yss[n] using filter() function
b = [1];
a = [1 -0.8];
y = filter(b, a, x);

% plot x[n] and y[n]
fig = figure;
% x[n]
subplot(2, 1, 1); 
stem(n, x, 'filled', 'MarkerSize', 2);
xlabel('n'); ylabel('x[n]'); grid;
xlim([min(n) max(n)]); ylim([-5 5]);
title('Input Sequence');
% y[n]
subplot(2, 1, 2); 
stem(n, y, 'filled', 'MarkerSize', 2);
xlabel('n'); ylabel('y[n]'); grid;
xlim([min(n) max(n)]); ylim([-5 5]);
title({'';'Output Sequence'});

% From the plots, we note that the amplitude of yss[n] is approximately 4. 
% To determine the shift in the output sinusoid, we can compare zero 
% crossings of the input and the output.

disp('Rough Comparison:');
disp(['Magnitude Change Factor = ', num2str(max(y)/max(x)), ' (about 4.0928)']);
disp(['Phase Change = ', 'about 3.42, verified by figure']);

