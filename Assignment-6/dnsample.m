% <function>
% downsamples sequence x[n] by a factor M to obtain y[n] = x[nM],
% adds shift before downsampling if optional input 'd' provided,
% extends sequence to include n=r data-point before downsampling 
% if optional input 'r' provided.
%
% <syntax>
% [y, m] = dnsample(x, n, M, <d>, <r>)
%
% <I/O>
% y = output (dilated) sequence = x[nM]
% x = input sequence x[n]
% M = decimation factor
% d = optional delay by 'd' samples before downsampling
% r = n-axis point to include in sequence before downsampling

function [y, m] = dnsample(x, n, M, d, r)
    
    % M must be a non-zero positive number (int)
    if (M <= 0); error('M must be a non-zero positive number'); end;
    M = round(M, 0);
    
    % check for shift parameter
    if nargin >= 4
        n = n + d;
    end

    % extend to include n=r, if requested
    if nargin == 5
        if n(end) < r
            n_end = n(end);
            n = [n n_end+1:r];
            x = [x zeros(1, r-n_end)];
        elseif n(1) > r
            n_start = n(1);
            n = [r:n_start-1 n];
            x = [zeros(1, n_start-r) x];
        end
    end
    
    % mod(a, b): nonzero results are always negative if the divisor is negative
    % and always positive if the divisor is positive
    diff = mod(n(1), M);
    
    % keeping y[0]=x[0.M]=x[0], beginning m value should be
    if diff == 0
        m_b_inx = 1;                        % starts at same value as in n
    else 
        m_b = n(1) + M - mod(n(1), M);
        m_b_inx = find(n == m_b, 1);        % index in n of beginning m value
    end
    
    % decimate x[n] to get y[n]=x[nM]
    m = n(m_b_inx:M:end)/M;
    y = x(m_b_inx:M:end);
    
end
