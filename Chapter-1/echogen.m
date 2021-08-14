% Section 1.3
% ECHO GENERATION function

function y = echogen(x, alpha, D)

b = [1,zeros(1,D),alpha];   % Filter parameters
y = filter(b,1,x);          % Generate sound plus its echo