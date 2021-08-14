% TASK-2 (Lab 6) assigned on 17/05/2021
% [Chp 2 Section 2.5 Page 55] (PROBLEM 2.8)

% ------------
% (Q2)
% ------------
% Generate x[n] = sin(0.125πn) , − 50 ≤ n ≤ 50. Decimate x[n] by a factor  of 4 to 
% generate y[n]. Plot both x[n] and y[n] using subplot, and comment on the results.
% ------------

% define sequence x[n]
n = -50:50;
x = sin(0.125*pi*n);

% decimate x[n] by M=4
M = 4;
[y, m] = dnsample(x, n, M);

% plot sequences x[n] and y[n] (using function defined at end of this script)
plotXY_t2(x, n, y, m, M, 'sin(0.125\pin)');

% ------------
% (Q3)
% ------------
% Repeat the above using x[n] = sin(0.5πn) , − 50 ≤ n ≤ 50. 
% Qualitatively discuss the effect of down-sampling on signals.
% ------------

% define sequence x[n]
n = -50:50;
x = sin(0.5*pi*n);

% decimate x[n] by M=4
M = 4;
[y, m] = dnsample(x, n, M);

% plot sequences x[n] and y[n] (using function defined at end of this script)
plotXY_t2(x, n, y, m, M, 'sin(0.5\pin)');


% ------------
% Function to plot x[n] and y[n] (decimated) in 2x1 subplot
% ------------
function plotXY_t2(x, n, y, m, M, x_eq)
    fig = figure; set(fig,'Units','normalized','Position',[0 0 1.4 1]);
    % plot x[n]
    subplot(2, 1, 1);
    stem(n, x, 'filled', 'MarkerSize', 5);
    xlabel('n'); ylabel('x[n]'); xlim([min(n) max(n)]);
    title({['x[n] = ', x_eq,'   (original sequence)'];''}, 'FontSize', 16);
    ax = gca; ax.FontSize = 16;
    % plot y[n]
    subplot(2, 1, 2);
    stem(m, y, 'filled', 'MarkerSize', 5);
    xlabel('n'); ylabel('y[n]'); xlim([min(n)/4 max(n)/4]); ylim([min(x) max(x)]);
    title({'';['y[n] = x[nM] = x[', num2str(M), 'n]   (decimated sequence)'];''}, 'FontSize', 16);
    ax = gca; ax.FontSize = 16;
end
