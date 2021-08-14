% <function>
% computes system output y for 0 <= n <= len(x)-1 using CCDE (forward) recurrence formula,
% given b, a, x (for n>=0), and initial conditions (N aux y values, M initial x values).
% assumes x[n] starts at n=0.
%
% <syntax>
% [y, ny] = get_system_out(b, a, x, N_aux, M_init)
%
% <I/O>
% y = filter output { y[-N], y[-N+1], ..., y[-1], y[0], y[1], ..., y[len(x)-1] }
% b = M+1 coefficients { b0, b1, ..., bM } for { x[0], x[-1], ..., x[-M] }
% a = N+1 coefficients { a0, a1, ..., aN } for { y[0], y[-1], ..., y[-N] }
% N_aux = N auxiliary y values { y[-1], y[-2], ...., y[-N] }
% M_init = M initial x values { x[-1], x[-2], ...., x[-M] }

function [y, ny] = get_system_out(b, a, x, N_aux, M_init)
    
    % basic testing of inputs
    if ~((length(N_aux)+1)==length(a)) 
        error('Length of "a" should Length of "N_aux" + 1'); 
    elseif ~((length(M_init)+1)==length(b)) 
        error('Length of "b" should Length of "M_init" + 1');
    end

    % setup y and x for forward recursive computation, and other variables
    y = [wrev(N_aux) zeros(1, length(x))];
    x2 = [wrev(M_init) x];
    N = length(N_aux);
    M = length(M_init);
    ny = -N:length(x)-1;
    
    % starting indexes for x and y -> x[0] and y[0]
    ix = M + 1;
    iy = N + 1;
    
    % compute y[n] for n=0 to n=len(x)-1 
    for i = 0:length(x)-1
        
        % (mult. with bM:b0 and) sum n-M to n-0 values of x (here, n=ix)
        x_sum = x2(ix-M:ix) * wrev(b)';
        
        % (mult. with aN:a1 and) sum n-N to n-1 values of y (here, n=iy)
        y_sum = y(iy-N:iy-1) * wrev(a(2:end)).';
        
        % compute current y value (at n=iy) (here, a(1) = a0)
        y(iy) = (-y_sum + x_sum) / a(1);
        
        ix = ix + 1;
        iy = iy + 1;
    end
end
