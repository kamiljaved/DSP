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

