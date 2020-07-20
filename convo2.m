%convolution property of DFT
clf;
w = -pi:2*pi/255:pi;
x1 = [1 3 5 7 9 11 13 15 17]; %signal 1
x2 = [1 -2 3 -2 1]; %signal 2
y = conv(x1,x2);
h1 = freqz(x1,1,w);
h2 = freqz(x2,1,w);
hp = h1.*h2; %multiplication of signals in frequency domain
h3 = freqz(y,1,w);% frequency response of the convoluted signals
%plot mag of multiplied signals 
figure(1);
plot(w/pi, abs(hp));grid;
title('Mag of  multiplied responses');
%plot mag of convoluted signals
figure(2);
plot(w/pi, abs(h3));grid;
title('Mag of convoluted responses');
%plot phase of multiplied signals
figure(3);
plot(w/pi, angle(hp));grid;
title('phase of multiplied responses');
%plot phase of convoluted signals
figure(4);
plot(w/pi, angle(h3));grid;
title('phase of convoluted responses');
%hence proved multiplication in time domain is equal to convolution in
%frequency domain

