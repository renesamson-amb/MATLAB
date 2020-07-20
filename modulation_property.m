%   Modulation property of DTFT
%   IF G[e^jw] <=> g[n]
%   If H[e^jw] <=> h[n]
%   multiplication of these signals in time domain is the 
%   convolution of the signals in frequency domain

clf;
w = -pi:2*pi/255:pi;
x1 = [1 3 5 7 9 11 13 15 17];
x2 = [1 -1 1 -1 1 -1 1 -1 1];
y = x1.*x2;
h1 = freqz(x1, 1, w);
h2 = freqz(x2, 1, w);
h3 = freqz(y , 1, w);
%figure
figure(1);
plot(w/pi, abs(h1));grid;
title('Magnitude spectrum of First sequence');
figure(4);
plot(w/pi,angle(h1));grid;
title('phase spectrum of first sequence');

%figure 2
figure(2);
plot(w/pi, abs(h2));grid;
title('Magnitude spectrum of second sequence');
figure(5);
plot(w/pi,angle(h2));grid;
title('phase spectrum of second sequence');
%figure 3
figure(3);
plot(w/pi, abs(h3));grid;
title('Magnitude Spectrum of product sequence');
figure(6);
plot(w/pi, angle(h3));grid;
title('phase spectrum of product sequence');