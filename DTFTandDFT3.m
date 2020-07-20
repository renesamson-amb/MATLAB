%time shiting property of DTFT
clf;
w = -pi:2*pi/255:pi; wo = 0.4*pi ; D = 10;
num = [1 2 3 4 5 6 7 8 9];
h1 = freqz(num,1,w);
h2 = freqz([zeros(1,D) num],1,w);

%magnitude of original signal
figure(1);
plot(w/pi,abs(h1));grid;
title('Magnitude spectrum of Original sequence');

%magnitude of time shifted signal
figure(2);
plot(w/pi,abs(h2));grid;
title('Magnitude spectrum of time shifted sequence');
 
%phase spectrum of orignial signal
figure(3);
plot(w/pi,angle(h1));grid;
title('phase spectrum of Original sequence');

%phase spectrum of time shifted signal
figure(4);
plot(w/pi,angle(h2));grid;
title('Phase spectrum of time shifted sequence');

%inference : time shift in time domain
%magnitude response remains intact
%and increases the frequency with which the phase varies

