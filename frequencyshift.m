%frequency shifting of DFT
clf;
w = -pi:2*pi/255:pi;wo=0.4*pi;
num1 = [1 3 5 7 9 11 13 15];
L = length(num1);
h1 = freqz(num1,1,w);
n = 0:L-1;
num2 = exp(wo*i*n).*num1;
h2 = freqz(num2,1,w);
%plot mag of original signal
figure(1);
plot(w/pi,abs(h1));grid;
title('Magnitude spectrum of original signal');
%plot mag of frequency shifted signal
figure(2);
plot(w/pi,abs(h2));grid;
title('Magnitude spectrum of frequency shifted signal');
%plot the phase of original signal
figure(3);
plot(w/pi,angle(h1));grid;
title('Phase spectrum of original signal');
%plot the phase of frequency shifted signal
figure(4);
plot(w/pi,angle(h2));grid;
title('Phase spectrum of frequency shifted signal');



%inference: time shift adds significantly to the phase spectrum
%frequency shift adds to the magnitude spectrum
 