% Code Snippets from Section 1.3

% ECHO GENERATION
% x[n] = y[n] + αy[n − D],  |α| < 1

load handel;                % The signal is in y and sampling freq in Fs
sound(y, Fs); pause(10);    % Play the original sound

alpha = 0.9; D = 4196;      % Echo parameters
b = [1 zeros(1, D) alpha];  % Filter parameters

x = filter(b, 1, y);        % Generate sound plus its echo (doc filter)
sound(x, Fs);               % Play sound with echo

% ECHO REMOVAL
% w[n] + αw[n − D] = x[n]

w = filter(1, b, x);
sound(w, Fs)

% DIGITAL REVERBERATION
% another natural-sounding reverberation is given by
% x[n] = αy[n] + y[n − D] + αx[n − D],  |α| < 1

