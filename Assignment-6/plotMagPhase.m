% <function> 
% plots given magnitude and phase response against given w values, 
% and magnitude against f (CT-domain frequencies) if f-axis array provided.
%
% <syntax>
% plotMagPhase(w, Xw_mag, Xw_ang, X, <f>, <mag_ylim>)
%
% <I/O>
% w = DT frequencies array [-pi, pi]
% Xw_mag = DTFT magnitude
% Xw_ang = DTFT phase
% X = name of DTFT for label/title in plot
% f = optional CT frequencies array
% mag_ylim = optional y-axis limit for DTFT magnitude

function plotMagPhase(w, Xw_mag, Xw_ang, X, f, mag_ylim)
    
    % plot magnitude and phase of DTFT X(w)
    fig = figure; 
    set(fig,'Units','normalized','Position',[0 0 1.4 1]);

    % plot magnitude of X(w) vs w
    subplot(1, 2, 1);
    plot(w, Xw_mag);
    xlabel('w   (radians/sample)'); ylabel(['|',X,'(e^{jw})|']);
    if nargin == 6; ylim(mag_ylim); end
    title({['Magnitude of ',X,'(e^{jw}) vs w'];''}, 'FontSize', 16);
    setDTFTradialAxis(1); 
    ax = gca; ax.FontSize = 16;
    
    % plot phase of X(w) vs w
    subplot(1, 2, 2);
    plot(w, Xw_ang);
    xlabel('w   (radians/sample)'); ylabel(['∠',X,'(e^{jw})   (degrees)']);
    title({['Phase of ',X,'(e^{jw}) vs w'];''}, 'FontSize', 16);
    setDTFTradialAxis(1); 
    ax = gca; ax.FontSize = 16;
    
    if nargin >= 5
        % plot magnitude of X(w) vs CT-domain frequencies f
        fig = figure;
        plot(f, Xw_mag);
        xlabel('f   (Hz)'); ylabel(['|',X,'(e^{jw})|']);
        xlim([-6e3 6e3]); xticks(-5e3:2e3:5e3);
        if nargin == 6; ylim(mag_ylim); end
        title({'';['Magnitude of ',X,'(e^{jw}) vs CT-Domain Frequencies f'];''});
    end
    
end