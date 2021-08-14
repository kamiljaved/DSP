function setDTFTradialAxis(p)

    if nargin == 1
        if p == 1; step = 0.5; else; step = 1; end
        wlabels = genWlabels(step);
        sDTFTra([-pi pi]*p, -pi*p:step*pi:pi*p, wlabels);
    else
        sDTFTraDefault();           % for w = [-2*pi, 2*pi]
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

end