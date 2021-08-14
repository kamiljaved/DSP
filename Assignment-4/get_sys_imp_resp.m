% <function>
% computes system impulse response h[n] for 0 <= n <= P using get_system_out(),
% given symbolic H(z) or numeric {b, a} CCDE coefficients, x (for n>=0),
% and initial conditions (N aux y values, M initial x values).
%
% <syntax>
% [h, nh] = get_sys_imp_resp(Hz|{b,a}, P)
% [h, nh] = get_sys_imp_resp(Hz|{b,a}, P, N_aux, M_init)
%
% <I/O>
% h = filter impulse resp. { h[-N], h[-N+1], ..., h[-1], h[0], h[1], ..., h[P] }
% Hz = system H(z) expression (type 'sym') of form B(z)/A(z) 
%    = (b0 + b1.z^-1 + ..... + bM.z^-M)/(a0 + a1.z^-1 + ..... + aN.z^-N)
% {b, a} = system CCDE coefficients (type 'cell' of size [1,2])
% N_aux = N auxiliary y values { y[-1], y[-2], ...., y[-N] }
% M_init = M initial x values { x[-1], x[-2], ...., x[-M] }

function [h, nh] = get_sys_imp_resp(Hz, P, N_aux, M_init)

    % acceptable number of inputs
    if ~any([2 4] == nargin)
        error('Wrong Number of Input Arguments. Allowed: 2, 4.');
    end
    
    % check whether H(z) or the {b, a} coefficients are provided
    % in either case, extract the coefficients (b's and a's)
    if and(isequal(class(Hz), 'cell'), isequal(size(Hz), [1,2]))
        b = Hz{1};
        a = Hz{2};
    elseif isequal(class(Hz), 'sym')
        [b, a] = get_zsys_coeffs(Hz)
    else
        error("H(z) must either be a sym exp. or a cell of size 1x2");
    end
    
    % if initial conditions not provided, assume zero i.c. (rest)
    if (nargin == 2)
        N_aux = zeros(1, length(a)-1);
        M_init = zeros(1, length(b)-1);
    end

    % generate input sequence x[n] = impluse of length P+1
    % <syntax> [x, n] = impseq(n0, n1, n2) where n1 <= n0 <= n2
    [delta, n] = impseq(0, 0, P);
    
    % compute the impulse response h[n] using get_system_out()
    [h, nh] = get_system_out(b, a, delta, N_aux, M_init);
    
    % plot the impulse response h[n] of the system
    figure;
    stem(nh, h, 'filled', 'MarkerSize', 4);
    xlabel('n'); ylabel('h[n]'); 
    xlim([0 length(delta)]);
    title({'Impulse Response h[n] of given system';''});
    
end
