% [Chp 2 Section 2.3 Page 44]
%
%  EXAMPLE 2.9
%  
%  Perform the convolution in Example 2.8 using the conv m function.
%

x = [3 11 7 0 -1 4 2]; 
nx = -3:3;
h = [2 3 0 -5 2 1]; 
nh = -1:4;

[y, ny] = conv_m(x,nx,h,nh)

subplot(2, 2, 1);
stem(nx, x); 
title('x[n] vs n');
xlabel('n'); ylabel('x[n]'); 
xlim([min(nx) max(nx)]);

subplot(2, 2, 2); 
stem(nh, h); 
title('h[n] vs n');
xlabel('n'); ylabel('h[n]'); 
xlim([min(nh) max(nh)]);

subplot(2, 2, 4); 
stem(ny, y); 
title('y[n] vs n');
xlabel('n'); ylabel('y[n]');
xlim([min(ny) max(ny)]);
