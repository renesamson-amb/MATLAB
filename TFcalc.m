%linear and nonlinear system
clf;
n = 0:40;
a= 2; b = -3;
x1 = cos(2*pi*0.1*n);
x2 = cos(2*pi*0.4*n);
x = a*x1 + b* x2;
%aim 
%to implement
%y[n] - 0.4y[n-1] +0.75y[n-2] = 2.2403x[n] +2.4908x[n-1]+2.2403x[n-2]
%TF => numerator filter coefficients {x[n] coefficients}
%   => denominator filter coefficients {y[n] coefficients}
num = [2.2403 2.4908 2.2403];
denom = [1 -0.4 0.75];
%setting initial conditions
ic = [0 0];
y1 = filter(num,denom,x1,ic);
y2 = filter(num,denom,x2,ic);
y3 = filter(num,denom,x,ic);
%for comparison total input is computed
yt = a*y1 + b*y2;
%if both yt and y3 are same then their difference is zero
d = y3 - yt;
figure(1);
stem(n,y3);
ylabel('Amplitude');xlabel('time index n');
title('output due to weighted input');
%second figure
figure(2);
stem(n,yt);
ylabel('Amplitude');xlabel('time index n');
title('output computed linearly');
figure(3);
stem(n,d);
ylabel('Amplitude');xlabel('time index n');
title('difference output');


