%cascade realization
clf;
%aim to generate the impulse response of length N =0: 40
x = [1 zeros(1,40)];
ic = [0 0]; %initial condition specified
%first part relaization
num1 = [0.3 -0.3 0.4];
denom1 = [1 0.9 0.8];
y1 = filter(num1,denom1,x,ic);
%second part realization

num2  =[0.2 -0.5 0.3];
denom2 = [1 0.7 0.85];
y2 = filter(num2,denom2,y1,ic);
%figure of cascaded output impulse response
figure(1);
stem(y2);
title('cascaded impulse response');
xlabel('time index n');ylabel('Amplitude');
%total part realization
num = [0.06 -0.19 0.27 -0.26 0.12];
den = [1 1.6 2.28 1.325 0.68];
y = filter(num,den,x);
%Total filter with no cascading output
figure(2); 
stem(y);
title('no cascade impulse response');
xlabel('time index n'); ylabel('Amplitude');
%difference signal
d = y - y2;     %difference signal 
figure(3);
stem(d);
title('difference signal');
xlabel('time index n');ylabel('Amplitude');

