dw = 0.001;
w = -pi:dw:pi;

syms z;
Hz_N = (z^-1-0.9*exp(-1i*0.2*pi))*(z^-1-0.9*exp(1i*0.2*pi));        % numerator of H(z)
Hz_D = (1-0.9*exp(1i*0.2*pi)*z^-1)*(1-0.9*exp(-1i*0.2*pi)*z^-1);    % denominator of H(z)
Hz = Hz_N/Hz_D;

Hz = vpa(simplify(Hz), 5)
[N, D] = numden(Hz)

b = fliplr(coeffs(N));
a = fliplr(coeffs(D));
b = double(b./a(1))
a = double(a./a(1))
figure;
zplane(b, a);

gd = grpdelay(b, a, w);
figure;
plot(w, gd);
setDTFTradialAxis(1);