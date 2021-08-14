% <function> 
% plots given sequence against given n values and its given DTFT 
% (magnitude and phase response) against given w values.
%
% <syntax>
% plotSeqDTFT(n, x, w0, w, Xw_mag, Xw_arg, Nn, Nw, <n1>, <x1>, <Nn1>, <skipDTFTplot>)
%
% <I/O>
% x = sequence x[n] array
% w0 = center frequency of x[n]
% w = DT frequencies array [-pi, pi]
% Xw_mag = DTFT magnitude
% Xw_arg = DTFT phase (unwrapped)
% Nn = name of sequence for label/title in plot
% Nw = name of DTFT for label/title in plot
% x1 = optional second sequence x1[n1] to plot against x[n]
% Nn1 = name of optional second sequence
% skipDTFTplot = boolean to indicate whether to skip plotting DTFT

function plotSeqDTFT(n, x, w0, w, Xw_mag, Xw_arg, Nn, Nw, n1, x1, Nn1, skipDTFTplot)
    
    % default is to plot DTFT (not skip)
    if ~(nargin == 12); skipDTFTplot = 0; end
    
    if nargin >= 11
        % plot first sequence x1[n1] for comparison
        fig = figure; set(fig,'Units','normalized','Position',[0 0 1.4 1]);
        subplot(1, 2, 1);
        hold on;
            stem(n1, x1, 'filled', 'MarkerSize', 3);
            n2 = min(n1):1/1000:max(n1);
            plot(n2, interp1(n1,x1,n2,'spline'), '--');
        hold off;
        xlabel('n'); ylabel([Nn1, '[n]']);
        title({'';['{\bf', Nn1, '[n] vs n}', '    (\omega_0 = ', ...
            num2str(w0/pi), '\pi)'];''}, 'FontSize', 16, 'FontWeight', 'normal');
        ax = gca; ax.FontSize = 16;
        subplot(1, 2, 2);
    else
        figure;
    end
    
    % plot x[n] vs n
    hold on;
        stem(n, x, 'filled', 'MarkerSize', 3);
        n2 = min(n):1/1000:max(n);
        plot(n2, interp1(n,x,n2,'spline'), '--');
    hold off;
    xlabel('n'); ylabel([Nn, '[n]']);
    if nargin >= 11
        xlim([min(n1) max(n1)]);
        title({'';['{\bf', Nn, '[n] vs n}', '    (\omega_0 = ', ...
            num2str(w0/pi), '\pi)'];''}, 'FontSize', 16, 'FontWeight', 'normal');
        ax = gca; ax.FontSize = 16;
    else
        title({'';['{\bf', Nn, '[n] vs n}', '    (\omega_0 = ', ...
            num2str(w0/pi), '\pi)'];''}, 'FontWeight', 'normal'); 
    end
    
    if ~skipDTFTplot
        % plot magnitude and phase of DTFT X(w) vs w
        fig = figure; set(fig,'Units','normalized','Position',[0 0 1.45 1.1]);
        subplot(1, 2, 1);
        plot(w, Xw_mag);
        xlabel('w   (radians/sample)'); ylabel(['|', Nw, '(e^{jw})|']);
        title({'';['{\bfMagnitude of ', Nw, '(e^{jw}) vs w}', '    (\omega_0 = ', ...
            num2str(w0/pi), '\pi)'];''}, 'FontSize', 16, 'FontWeight','normal');
        setDTFTradialAxis(1); 
        ax = gca; ax.FontSize = 16;
        subplot(1, 2, 2);
        plot(w, Xw_arg);
        xlabel('w   (radians/sample)'); ylabel(['∠', Nw, '(e^{jw})   (radians)']);
        title({'';['{\bfPhase (unwrapped) of ', Nw, ...
            '(e^{jw}) vs w}', '    (\omega_0 = ', num2str(w0/pi), '\pi)'];''}, ...
            'FontSize', 16, 'FontWeight','normal');
        setDTFTradialAxis(1, 10, 1); 
        ax = gca; ax.FontSize = 16;
    end
    
end