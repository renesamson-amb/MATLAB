%   program  P3.2
%   Time-shifting properties of DTFT

w = -pi: 2*pi/255: pi; wo = 0.4*pi; D= 10;
num = [1 2 3 4 5 6 7 8 9 ];
%   freqz(b,a,n)
%   w point frequency response for filter
%   whose transfer function coefficients are stored in
%   b and a
h1 = freqz(num ,1 ,w);
h2 = freqz([zeros(1,D) num] , 1 ,w);

figure (1);
plot(w/pi,abs(h1)); grid;
title('magnitude spectrum of original sequence');
figure (2);
plot(w/pi, abs(h2)); grid;
title('Magnitude spectrum of Time-Shifted Sequence');
figure (3);
plot(w/pi,angle(h1));grid;
title('Phase Spectrum of Original sequence');
figure (4);
plot(w/pi,angle(h2)); grid;
title('Phase spectrum of Time-Shifted sequence');
