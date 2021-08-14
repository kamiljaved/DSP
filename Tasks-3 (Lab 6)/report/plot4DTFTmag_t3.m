% ------------
% Function to plot DTFTs (magintude, normalized) of any window for 4 M values
% ------------
function plot4DTFTmag_t3(dtfts, w, M, wind, wind_name)
    
    fig = figure; set(fig,'Units','normalized','Position',[0 0 1.1 1.6]); 
    
    for i = 1:4
        subplot(2, 2, i);
        
        % get the magnitude of XM(w)
        XMw_mag = abs(dtfts{i});
        
        % normalize the magnitude so that max value = 1
        XMw_mag_norm = XMw_mag/max(XMw_mag);
        
        % plot magnitude of DTFT XM(w)
        plot(w, XMw_mag_norm);
        xlabel('w   (radians/sample)'); 
        ylabel(['|', wind, '_M' ,'(e^{jw})|']);
        ttl = {['[M = ', num2str(M(i)), ']     Magnitude of ',...
            wind, '_M(e^{jw}) vs w'];''};
        if i > 2;  ttl = [{''}; ttl]; end;
        title(ttl);
        setDTFTradialAxis(1);
    end
    
    sgtitle([wind_name, '  ', wind, '_M[n]']);
end
