% <function> 
% plots given sequence(s) against given n values and their given DTFT 
% (magnitude and phase response) against given w values.
%
% <syntax>
% plot3SeqDTFT(n, a, wc, w, Aw_mag, Nn, Nw, Aw_arg, <off>, <align>)
%
% <I/O>
% a = {x[n], y[n], g[n]}
% wc = center frequency of a[n]
% w = DT frequencies array [-pi, pi]
% Aw_mag = {Xw_mag, Yw_mag, Gw_mag}
% Nn = {Nnx, Nny, Nng}
% Nw = {Nwx, Nwy, Nwg}
% Aw_arg = optional {Xw_arg, Yw_arg, Gw_arg}
% off = optional {offX, offY, offG}
% align = optional {alignWC, alignMX}

function plot3SeqDTFT(n, a, wc, w, Aw_mag, Nn, Nw, Aw_arg, off, align)
    
    if ~(nargin >= 8); Aw_arg = {}; end
    if ~(nargin >= 9); off = {zeros(1, 4), zeros(1, 4), zeros(1, 4)}; end
    if ~(nargin == 10); align = {'left', 'left'}; end
    lb2 = round(length(w)/2); w2 = w(lb2:end);
    
    for i = 1:length(n)
        % plot sequence a[n] and DTFT A(w) magnitude
        fig = figure;
        set(fig,'Units','normalized','Position',[0 0 1.4 1]);
        subplot(1, 2, 1);
        % plot a[n] vs n
        hold on;
            stem(n{i}, a{i}, 'filled', 'MarkerSize', 3);
            n2 = min(n{i}):1/1000:max(n{i});
            plot(n2, interp1(n{i},a{i},n2,'spline'), '--');
        hold off;
        xlabel('n'); ylabel([Nn{i}, '[n]']);
        if (i == 1)
            title({['{\bf', Nn{i}, '[n] vs n}'];''}, 'FontSize', 16);
        else
            title({'';['{\bf', Nn{i}, '[n] vs n}'];''}, 'FontSize', 16);
        end
        ax = gca; ax.FontSize = 16;
        subplot(1, 2, 2);
        % plot magnitude of A(w) vs w
        plot(w, Aw_mag{i});
        xlabel('w   (radians/sample)'); ylabel(['|', Nw{i}, '(e^{jw})|']);
        if (i == 1)
            title({['{\bfMagnitude of ', Nw{i}, '(e^{jw}) vs w}'];''}, 'FontSize', 16);
        else
            title({'';['{\bfMagnitude of ', Nw{i}, '(e^{jw}) vs w}'];''}, ...
                'FontSize', 16);
        end
        setDTFTradialAxis(1); 
        ax = gca; ax.FontSize = 16;
        hold on;
            yval = Aw_mag{i}(find(w>=wc-0.01 & w<=wc+0.01, 1));
            l1 = stem(wc, yval, 'k', 'filled', 'LineStyle', 'none', 'MarkerSize', 5);
            text(wc+off{i}(1), yval+off{i}(2), num2str(round(yval, 1)), ...
                'FontSize', 13, 'HorizontalAlignment', align{1});
            [yval, yinx] = max(Aw_mag{i}(lb2:end)); wval = w2(yinx);
            l2 = stem(wval, yval, 'r', 'filled', 'LineStyle', 'none', 'MarkerSize', 5);
            text(wval+off{i}(3), yval+off{i}(4), num2str(round(yval, 1)), ...
                'Color', 'r', 'FontSize', 13, 'HorizontalAlignment', align{2});
            legend([l1 l2], ['\omega_c = ', num2str(wc/pi), '\pi'], ...
                '{\color{red}max}', 'Location', 'northwest');
        hold off;
    end
    
    for i = 1:length(Aw_arg)
        % plot DTFT A(w) phase (unwrapped)
        fig = figure;
        set(fig,'Units','normalized','Position',[0 0 1.4 1]);
        subplot(1, 2, 1)
        plot(w, Aw_arg{i});
        xlabel('w   (radians/sample)'); ylabel(['∠', Nw{i}, '(e^{jw})   (radians)']);
        if (i == 1)
            title({['{\bfPhase (unwrapped) of ', Nw{i}, '(e^{jw}) vs w}'];''}, ...
                'FontSize', 16);
        else
            title({'';['{\bfPhase (unwrapped) of ', Nw{i}, '(e^{jw}) vs w}'];''}, ...
                'FontSize', 16);
        end
        step = round(max(abs([max(Aw_arg{i}) min(Aw_arg{i})]))/pi*0.2);
        setDTFTradialAxis(1, step, 1);
        ax = gca; ax.FontSize = 16;
    end
    
end