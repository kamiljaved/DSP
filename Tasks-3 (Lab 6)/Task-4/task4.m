% TASK-4 (Lab 6) assigned on 17/05/2021
% [Chp 3 Section 3.5 Page 99] (PROBLEM 3.9)

% ------------
% Using the frequency-shifting property of DTFT, show that the real part of X(e^jω) 
% of a sinusoidal pulse, 
%           x[n] = cos(ω0.n).RM[n]
% where RM[n] (rectangular pulse) = 1 for 0≤n<M and 0 otherwise, is given by,
%           XR(e^jω) =   1/2 cos{(ω-ω0)(M-1)/2} sin{(ω-ω0)M/2} / sin{(ω-ω0)/2}
%                      + 1/2 cos{(ω+ω0)(M-1)/2} sin{[ω-(2π-ω0)]M/2} / sin{[ω-(2π-ω0)]/2}
% Compute and plot XR(e^jω) for ω0 = π/2 and M = 5, 15, 25, 100, for interval [−π, π]. 
% Comment on your results.
% ------------

M = [5 15 25 100];                      % values of M for which to compute DTFT
w0 = pi/2;                              % given w0 value
w = -pi:0.01:pi;                        % frequency vector for computing DTFTs
XRw = cell(length(M), 1);               % cell-array to store DTFTs (real part) for each M

for i = 1:length(M)

    % define the rectangular pulse RM[n]
    n = 0:(M(i)-1);
    RM = ones(1, length(n));
    
    % define given x[n]
    x = cos(w0*n).*RM;
    
    % compute the DTFT of x[n] i.e. X(w), using matrix-mult. method
    Xw = x * exp(-1i * n' * w);
    
    % store the real part of DTFT i.e. XR(w)
    XRw{i} = real(Xw);
    
    % compare computed XR(w) with equation of XR(w) (given & derived in paperwork)
    XRw_eq = (1/2)*cos((w-w0)*(M(i)-1)/2).*sin((w-w0)*M(i)/2)./sin((w-w0)/2)...
             + (1/2)*cos((w+w0)*(M(i)-1)/2).*sin((w+w0)*M(i)/2)./sin((w+w0)/2);
    % message only displayed if results don't match
    if ~isequal(round(XRw{i}, 10), round(XRw_eq, 10)); disp('Result Mismatch'); end;

end

% plot DTFT real part XR(w) for each M value
fig = figure; set(fig,'Units','normalized','Position',[0 0 1 1.6]);
for i = 1:4
    subplot(2, 2, i);
    plot(w, XRw{i});
    xlabel('w   (radians/sample)'); 
    ylabel(['X_R' ,'(e^{jw})']);
    ttl = {['[M = ', num2str(M(i)), ']']};
    if i > 2;  ttl = [{''}; ttl]; end;
    title(ttl);
    setDTFTradialAxis(1);
end
sgtitle('X_R(e^{jw}) i.e. Real Part of X(e^{jw}) vs w');
