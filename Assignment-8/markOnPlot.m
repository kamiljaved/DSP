% <function> 
% marks given dat(x) values on plot.
%
% <syntax>
% markOnPlot(xvals, x, dat, tol, xoff, yoff, <txt>, <xdiv>, <rnd>)
%
% <I/O>
% xvals = values on x-axis to mark
% x = x-axis array
% dat = y-axis dat(x) array
% tol = tolerance in finding x-value in x-axis array
% xoff = horizontal offset of text (value/array)
% yoff = vertical offset of text (value/array)
% txt = cell structure specifying text to show around values
% xdiv = to show x-value/xdiv in text instead of x-value
% rnd = decimal places in rounded y-value

function markOnPlot(xvals, x, dat, tol, xoff, yoff, txt, xdiv, rnd)

    if length(xoff)==1; xoff = repelem(xoff, length(xvals));
    elseif isempty(xoff); xoff = repelem(0, length(xvals)); end
    if length(yoff)==1; yoff = repelem(yoff, length(xvals));
    elseif isempty(yoff); yoff = repelem(0, length(xvals)); end
    txt1 = 'y('; txt2 = ')'; txt_eq = '\approx';
    newline = 0;
    if nargin >= 7
        txt1 = txt{1}; txt2 = txt{2};
        if length(txt) >= 3
            if isequal(txt{3}, ''); newline = 1; 
            else; txt_eq = txt{2}; end
        end
    end
    if ~(nargin >= 8); xdiv = 1; end
    if ~(nargin == 9); rnd = 1; end
    
    hold on;
    for i = 1:length(xvals)
        yval = dat(find(x>=xvals(i)-tol & x<=xvals(i)+tol, 1));
        stem(xvals(i), yval, 'k', 'filled', 'LineStyle', 'none', 'MarkerSize', 4);
        if newline
          text(xvals(i)+xoff(i), yval+yoff(i), ...
            {[txt1, num2str(xvals(i)/xdiv), txt2]; ...
            [' ', txt_eq,' ', num2str(round(yval, rnd))]});          
        else
            text(xvals(i)+xoff(i), yval+yoff(i), ...
                [txt1, num2str(xvals(i)/xdiv), txt2, ...
                ' ', txt_eq,' ', num2str(round(yval, rnd))]);
        end
    end
    hold off;
    
end