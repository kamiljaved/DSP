% Section 1.3
% ECHO REMOVAL function

function w = echorem(x, alpha, D)

b = [1,zeros(1,D),alpha];   % Filter parameters
w = filter(1,b,x);