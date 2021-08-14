% [Chp 1 Section 1.2 Page 11]
%
%  EXAMPLE 1.1
%

% approach 1

t = 0:0.01:1;
N = length(t);
xt = zeros(1, N);

for n = 1:N
    temp = 0;
    for k = 1:2:5
        temp = temp + (1/k)*sin(2*pi*k*t(n));
    end
    xt(n) = temp;
end

% approach 2

t = 0:0.01:1;
xt = zeros(1,length(t));
for k = 1:2:5
    xt = xt + (1/k)*sin(2*pi*k*t);
end

% approach 3

t = 0:0.01:1;
k = 1:2:5;
xt = (1./k)*sin(2*pi*k'*t);

% function call (a bit different summation)

xt = sinsum(t, (1./k));

% plotting: continuous
t = 0:0.01:2;               % sample points from 0 to 2 in steps of 0.01
xt = sin(2*pi*t);           % Evaluate sin(2 pi t)
plot(t,xt,'b');             % Create plot with blue line
xlabel('t in sec'); ylabel('x(t)');     % Label axis
title('Plot of sin(2\pit)');            % Title plot

% plotting: discrete
n = 0:1:40;                 % sample index from 0 to 40
xn = sin(0.1*pi*n);         % Evaluate sin(0.1 pi n)
stem(n,xn,'b','filled','MarkerSize',4);     % Stem-plot
xlabel('n'); ylabel('x(n)');                % Label axis
title('Stem Plot of sin(0.1\pin)');         % Title plot

% plotting: depicting a “sampling” operation
plot(t,xt,'b');                     % Create plot with blue line
hold on;                            % do not erase already drawn content on next plot call
Hs = stem(n*0.05,xn,'b','filled');  % Stem-plot with handle Hs
set(Hs,'markersize',4);             % Change circle size
title('Plot of sin(2\pit) and its samples'); % Title plot
hold off;   

% plotting: subplots in same figure
subplot(2,1,1);         % Two rows, one column, activate first plot
plot(t,xt,'b');         % Create plot with blue line
title('Plot of sin(2\pit)');            % Title plot
subplot(2,1,2);         % Two rows, one column, activate second plot
Hs = stem(n,xn,'b','filled','MarkerSize',4);    % Stem-plot
title('Stem Plot of sin(0.1\pin)');         % Title plot


