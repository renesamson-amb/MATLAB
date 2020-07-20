%program for calculating impulse response
%compute the impulse response using impz
clf;
N=40;
num = [2.2403 2.4908 2.2403];
den = [1 -0.4 0.75];
y   =  impz(num,den,N);
%plot the impulse response
figure(1);
stem(y);
xlabel('Time index n'); ylabel('Amplitude');
title('Impulse Response');grid;