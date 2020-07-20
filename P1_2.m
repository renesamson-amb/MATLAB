%generation of complex exponential signal
clf;
c = -(1/12) + (pi/6)*i;
K = 2;
n = 0 : 40;
x = K*exp(c*n)
%logic for oscillating signal always involves pi
subplot(2,1,1);
stem(n, real(x));
xlabel('Time index n'); ylabel('Amplitude');
title ('real part');
%logic for oscillating signal always involves pi
subplot(2,1,2);
stem(n,imag(x));
xlabel('Time index n'); ylabel('Amplitude');
title('imag part');


