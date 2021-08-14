% TASK-2 (Lab 6) assigned on 17/05/2021
% [Chp 2 Section 2.5 Page 55] (PROBLEM 2.8)
%
% <function>
% downsamples sequence x[n] by a factor M to obtain y[n] = x[nM],
% returns empty vectors if no samples exist in resultant range.
%
% <syntax>
% [y, m] = dnsample(x, n, M)
%
% <I/O>
% x = input sequence x[n]
% M = decimation factor
% y = output (dilated) sequence = x[nM]

function [y, m] = dnsample(x, n, M)
    
    % M must be a non-zero positive number (int)
    if (M <= 0); error('M must be a non-zero positive number'); end;
    M = round(M, 0);
    
    % mod(a, b): nonzero results are always negative if the divisor is negative
    % and always positive if the divisor is positive
    diff = mod(n(1), M);
    
    % keeping y[0]=x[0.M]=x[0], beginning m value should be
    if diff == 0
        m_b_inx = 1;                        % starts at same value as in n
    else 
        m_b = n(1) + M - mod(n(1), M);
        m_b_inx = find(n == m_b, 1);        % index in n of beginning m value
        if ~isempty(m_b_inx) m_b_inx = m_b_inx(1); end;     % unnecessary?
    end
    
    % decimate x[n] to get y[n]=x[nM]
    m = n(m_b_inx:M:end)/M;
    y = x(m_b_inx:M:end);
    
end
