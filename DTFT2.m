%frequency shift  
clf;
w = -pi : 2*pi/255: pi; wo = 0.4*pi;
num1 = [1 3 5 7 9 11 13 15 17];
L = length(num1);
h1 = freqz(num1, 1 ,w);
n = 0:L-1;
%i from 0 to L-1;
num2 = exp(wo*i*n).*num1;
ft = fft(num1,201);
%   in the above statement exp expression is used to calculate the signal
%   num1 is the filter coefficients
h2= freqz(num2, 1, w);
figure (1);
plot(w/pi,abs(h1));grid;
title('Magnitude spectrum of Original signal');
figure(2);
plot(w/pi,abs(h2));grid;
title('Magnitude Spectrum of Frequency-shifted signal');
figure(3);
plot(w/pi, angle(h1));grid;
title('Phase spectrum of Origianl signal');
figure (4);
plot(w/pi,angle(h2));grid;
title('Phase spectrum of Frequency shifted signal');

%%%fft plots
figure(5);
oh = -100:1:100;
plot(oh,ft);
title('DFT plot of the signal');grid;
xlabel('num');ylabel('amplitude');