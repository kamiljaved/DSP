% <function>
% used in plotting (DTFT)
% sets limits, ticks and labels of the frequency axis in radians/second, 
% in terms of pi.
% also sets y-axis in terms of pi if any second argument provided
%
% <syntax>
% setDTFTradialAxis() or setDTFTradialAxis(p)
%
% <I/O>
% p = number of periods (of DTFT) to show, starting about the center (y-axis)
%     default is 2 periods i.e. w = [-2*pi, 2*pi]

function setDTFTradialAxis(p, y, keepOldYlim)

    if nargin >= 1
        if p == 1; step = 0.5; else; step = 1; end
        wlabels = genWlabels(step);
        sDTFTra([-pi pi]*p, -pi*p:step*pi:pi*p, wlabels);
    else
        sDTFTraDefault();           % for w = [-2*pi, 2*pi]
    end
    
    if nargin >= 2
        sDTFTray();
    end
    
    function sDTFTraDefault()
        sDTFTra([-2*pi 2*pi], [-2*pi -pi 0 pi 2*pi], ...
            {'-2\pi','-\pi','0','\pi','2\pi'});
    end
    
    function sDTFTra(wlim, wtick, wlabels)
        xlim(wlim);
        xticks(wtick);
        xticklabels(wlabels);
    end

    function wlabel = genWlabels(step)
        wlabel = cell(1, 2*p+1);
        k = 1;
        for i=-p:step:p
            if i == -1 
                wlabel{k} = '-\pi';
            elseif i == 0
                wlabel{k} = '0';
            elseif i == 1
                wlabel{k} = '\pi';
            else
                wlabel{k} = strcat(num2str(i), '\pi');
            end
            k = k+1;
        end
    end
    
    function sDTFTray
        glim = ylim;
        y_b = floor(glim(1)/pi); y_e = ceil(glim(end)/pi);
        ystep = y;
        ylim([y_b y_e]*pi);
        yticks((y_b:ystep:y_e)*pi);
        yvals = y_b:ystep:y_e;
        ylabels = cell(1, length(yvals));
        for i=1:length(yvals)
            if yvals(i) == -1 
                ylabels{i} = '-\pi';
            elseif yvals(i) == 0
                ylabels{i} = '0';
            elseif yvals(i) == 1
                ylabels{i} = '\pi';
            else
                ylabels{i} = strcat(num2str(yvals(i)), '\pi');
            end
        end
        yticklabels(ylabels);
        if keepOldYlim
            ylim(glim);
        end
    end
    
end
