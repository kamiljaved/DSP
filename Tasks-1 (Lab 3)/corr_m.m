% TASK (Lab 3 / Chapter 2)
% assigned on 19/04/2021

% modified correlation function, to accept and compute n axes

% <syntax>
% [rxy, nrxy] = corr_m(x, nx, y, ny)        % cross-correlation
% [rxx, nrxx] = corr_m(x, nx)               % auto-correlation

function [r, nr] = corr_m(x, nx, y, ny)

if nargin == 2
    % disp('auto-correlation');
    corr_compute_nr(nx(1), nx(length(x)), nx(1), nx(length(x)))
    r = xcorr(x);                       	% call in-built xcorr() function
elseif nargin == 4
    % disp('cross-correlation');
    corr_compute_nr(nx(1), nx(length(x)), ny(1), ny(length(y)))
    r = xcorr(x, y);                      	% call in-built xcorr() function
else
    error('Wrong number of input arguments. Acceptable: 2 or 4.')
end
    
    % nested function to compute n axes for correlation output
    function corr_compute_nr(nx_1, nx_2, ny_1, ny_2)
        nrxy_b = nx_1 + ny_1;              	% beginning n value for nr
        nrxy_e = nx_2 + ny_2;              	% ending n value for nr
        nr = nrxy_b:nrxy_e;               	% n vector for r
    end

end


