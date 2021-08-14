% TASK-3 (Lab 6) assigned on 17/05/2021
% [Chp 3 Section 3.5 Page 98] (PROBLEM 3.4)

% ------------
% For each of following windows, 
%           Rectangular:    RM[n]   = 1 for 0≤n<M, 0 otherwise
%           Hanning:        CM[n]   = 0.5( 1 - cos(2πn/(M-1)) ).RM[n]
%           Triangular:     TM([n]  = (1 - |M-1-2n|/(M-1)).RM[n]
%           Hamming:        HM[n]   = ( 0.54 - 0.46cos(2πn/(M-1)) ).RM[n]
% determine their DTFTs for M = 10, 25, 50, 101. Scale transform values so that the maximum 
% value is equal to 1. Plot the magnitude of the normalized DTFT over −π ≤ ω ≤ π. 
% Study these plots and comment on their behavior as a function of M.
% ------------

M = [10 25 50 101];                     % values of M for which to compute window DTFT
w = -pi:0.01:pi;                        % frequency vector for computing DTFTs of windows
    
% >>> window 1 <<< Rectangular: RM[n]

RM = cell(length(M), 1);                % cell-array to store window sequences for each M value
RMw = cell(length(M), 1);               % cell-array to store the DTFTs for each M value

for i = 1:length(M)

    % define RM[n] = 1 for 0≤n<M, 0 otherwise
    n = 0:(M(i)-1);
    RM{i} = ones(1, length(n));
    
    % compute the DTFT of RM[n] i.e. RM(w), using matrix-mult. method
    RMw{i} = RM{i} * exp(-1i * n' * w);
    
end

% plot DTFT magnitude |RM(w)| for each M (using function defined at end of this script)
plot4DTFTmag_t3(RMw, w, M, 'R', 'Rectangular Window');

% >>> window 2 <<< Hanning: CM[n]

CMw = cell(length(M), 1);               % cell-array to store the DTFTs for each M value

for i = 1:length(M)

    % define CM[n] = 0.5( 1 - cos(2πn/(M-1)) ).RM[n]   (for 0≤n<M)
    n = 0:(M(i)-1);
    CM = 0.5*(1 - cos(2*pi*n/(M(i)-1))).*RM{i};
    
    % compute the DTFT of CM[n] i.e. CM(w), using matrix-mult. method
    CMw{i} = CM * exp(-1i * n' * w);
    
end

% plot DTFT magnitude |CM(w)| for each M (using function defined at end of this script)
plot4DTFTmag_t3(CMw, w, M, 'C', 'Hanning Window');

% >>> window 3 <<< Triangular: TM[n]

TMw = cell(length(M), 1);               % cell-array to store the DTFTs for each M value

for i = 1:length(M)

    % define TM[n] = (1 - |M-1-2n|/(M-1)).RM[n]   (for 0≤n<M)
    n = 0:(M(i)-1);
    TM = (1 - abs(M(i)-1-2*n)/(M(i)-1)).*RM{i};
    
    % compute the DTFT of TM[n] i.e. TM(w), using matrix-mult. method
    TMw{i} = TM * exp(-1i * n' * w);
    
end

% plot DTFT magnitude |TM(w)| for each M (using function defined at end of this script)
plot4DTFTmag_t3(TMw, w, M, 'T', 'Triangular Window');

% >>> window 4 <<< Hamming: HM[n]

HMw = cell(length(M), 1);               % cell-array to store the DTFTs for each M value

for i = 1:length(M)

    % define HM[n] = ( 0.54 - 0.46cos(2πn/(M-1)) ).RM[n]   (for 0≤n<M)
    n = 0:(M(i)-1);
    HM = (0.54 - 0.46*cos(2*pi*n/(M(i)-1))).*RM{i};
    
    % compute the DTFT of HM[n] i.e. HM(w), using matrix-mult. method
    HMw{i} = HM * exp(-1i * n' * w);
    
end

% plot DTFT magnitude |HM(w)| for each M (using function defined at end of this script)
plot4DTFTmag_t3(HMw, w, M, 'H', 'Hamming Window');


% ------------
% Function to plot DTFTs (magintude, normalized) of any window for 4 M values
% ------------
function plot4DTFTmag_t3(dtfts, w, M, wind, wind_name)
    
    fig = figure; set(fig,'Units','normalized','Position',[0 0 1 1.6]); 
    
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
