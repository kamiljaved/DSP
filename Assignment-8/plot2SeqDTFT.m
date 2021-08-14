% <function> 
% plots given sequence(s) against given n values and their given DTFT 
% (magnitude and phase response) against given w values.
%
% <syntax>
% plot2SeqDTFT(n, x, wc, w, Xw_mag, Xw_arg, Nn, Nw, off, ...
%     <ny>, <y>, <Yw_mag>, <Yw_arg>, <Nny>, <Nwy>, <align1>, <align2>);
%
% <I/O>
% x = sequence x[n] array
% wc = center frequency of x[n]
% w = DT frequencies array [-pi, pi]
% Xw_mag = DTFT magnitude
% Xw_arg = DTFT phase (unwrapped)
% Nn = name of sequence x[n] for label/title in plot
% Nw = name of DTFT X(w) for label/title in plot
% off = offsets for texts in form of array
% y = optional sequence y[n] array
% Yw_mag = optional y[n] DTFT magnitude
% Yw_arg = optional y[n] DTFT phase (unwrapped)
% Nny = name of optional sequence y[n] for label/title in plot
% Nwy = name of optional y[n] DTFT for label/title in plot

function plot2SeqDTFT(n, x, wc, w, Xw_mag, Xw_arg, Nn, Nw, off, ...
    ny, y, Yw_mag, Yw_arg, Nny, Nwy, align1, align2);
    
    if length(off) < 4; off = [off repelem(0, 4-length(off))]; end; 
    plt2 = 0;
    if nargin >= 10
        plt2 = 1;
        if length(off) < 8; off = [off repelem(0, 8-length(off))]; end;
    end
    if ~(nargin >= 16); align1 = 'left'; end
    if ~(nargin == 17); align2 = 'left'; end
    lb2 = round(length(w)/2); w2 = w(lb2:end);

    % plot sequence(s)
    fig = figure;
    if plt2
        set(fig,'Units','normalized','Position',[0 0 1.4 1]);
        subplot(1, 2, 1);
    end
        % plot x[n] vs n
        hold on;
            stem(n, x, 'filled', 'MarkerSize', 3);
            n2 = min(n):1/1000:max(n);
            plot(n2, interp1(n,x,n2,'spline'), '--');
        hold off;
        xlabel('n'); ylabel([Nn, '[n]']);
        if plt2
            title({['{\bf', Nn, '[n] vs n}'];''}, 'FontSize', 16);
            ax = gca; ax.FontSize = 16;
        else
            title({'';['{\bf', Nn, '[n] vs n}'];''});
        end
    if plt2
        subplot(1, 2, 2);
        % plot y[n] vs n
        hold on;
            stem(ny, y, 'filled', 'MarkerSize', 3);
            n2 = min(ny):1/1000:max(ny);
            plot(n2, interp1(ny,y,n2,'spline'), '--');
        hold off;
        xlabel('n'); ylabel([Nny, '[n]']);
        xlim([min(n) max(n)]);
        title({['{\bf', Nny, '[n] vs n}'];''}, 'FontSize', 16);
        ax = gca; ax.FontSize = 16;
    end
        
    % plot magnitude and phase of DTFT X(w) vs w
    fig = figure; set(fig,'Units','normalized','Position',[0 0 1.4 1]);
    subplot(1, 2, 1);
    plot(w, Xw_mag);
    xlabel('w   (radians/sample)'); ylabel(['|', Nw, '(e^{jw})|']);
    title({'';['{\bfMagnitude of ', Nw, '(e^{jw}) vs w}'];''}, 'FontSize', 16);
    setDTFTradialAxis(1); 
    ax = gca; ax.FontSize = 16;
    hold on;
        yval = Xw_mag(find(w>=wc-0.01 & w<=wc+0.01, 1));
        l1 = stem(wc, yval, 'k', 'filled', 'LineStyle', 'none', 'MarkerSize', 5);
        text(wc+off(1), yval+off(2), num2str(round(yval, 1)), ...
            'FontSize', 13, 'HorizontalAlignment', align1);
        [yval, yinx] = max(Xw_mag(lb2:end)); wval = w2(yinx);
        l2 = stem(wval, yval, 'r', 'filled', 'LineStyle', 'none', 'MarkerSize', 5);
        text(wval+off(3), yval+off(4), num2str(round(yval, 1)), ...
            'Color', 'r', 'FontSize', 13, 'HorizontalAlignment', align2);
        legend([l1 l2], ['\omega_c = ', num2str(wc/pi), '\pi'], ...
            '{\color{red}max}', 'Location', 'northwest');
    hold off;
    subplot(1, 2, 2);
    plot(w, Xw_arg);
    xlabel('w   (radians/sample)'); ylabel(['∠', Nw, '(e^{jw})   (radians)']);
    title({'';['{\bfPhase (unwrapped) of ', Nw, '(e^{jw}) vs w}'];''}, ...
        'FontSize', 16);
    step = round(max(abs([max(Xw_arg) min(Xw_arg)]))/pi*0.2);
    setDTFTradialAxis(1, step, 1);
    ax = gca; ax.FontSize = 16;

    if plt2
        % plot magnitude and phase of DTFT Y(w) vs w
        fig = figure; set(fig,'Units','normalized','Position',[0 0 1.4 1]);
        subplot(1, 2, 1);
        plot(w, Yw_mag);
        xlabel('w   (radians/sample)'); ylabel(['|', Nwy, '(e^{jw})|']);
        title({'';['{\bfMagnitude of ', Nwy, '(e^{jw}) vs w}'];''}, 'FontSize', 16);
        setDTFTradialAxis(1); 
        ax = gca; ax.FontSize = 16;
        hold on;
            yval = Yw_mag(find(w>=wc-0.01 & w<=wc+0.01, 1));
            l1 = stem(wc, yval, 'k', 'filled', 'LineStyle', 'none', 'MarkerSize', 5);
            text(wc+off(5), yval+off(6), num2str(round(yval, 1)), ...
                'FontSize', 13, 'HorizontalAlignment', align1);     
            [yval, yinx] = max(Yw_mag(lb2:end)); wval = w2(yinx);
            l2 = stem(wval, yval, 'r', 'filled', 'LineStyle', 'none', 'MarkerSize', 5);
            text(wval+off(7), yval+off(8), num2str(round(yval, 1)), ...
                'Color', 'r', 'FontSize', 13, 'HorizontalAlignment', align2);
            legend([l1 l2], ['\omega_c = ', num2str(wc/pi), '\pi'], ...
                '{\color{red}max}', 'Location', 'northwest');
        hold off;
        subplot(1, 2, 2);
        plot(w, Yw_arg);
        xlabel('w   (radians/sample)'); ylabel(['∠', Nwy, '(e^{jw})   (radians)']);
        title({'';['{\bfPhase (unwrapped) of ', Nwy, '(e^{jw}) vs w}'];''}, ...
            'FontSize', 16);
        step = round(max(abs([max(Yw_arg) min(Yw_arg)]))/pi*0.2);
        setDTFTradialAxis(1, step, 1);
        ax = gca; ax.FontSize = 16;
    end

end