%program 2.4
clf;
n = 0:40;D = 2; a = 3.0; b = -2;
x = a*cos(2*pi*0.1*n) + b*cos(2*pi*0.4*n);
xd = [zeros(1,D) x];
num = [2.2403 2.4908 2.2402];
denom =[ 1 -0.4 0.75];
ic = [0 0];
y= filter(num,denom,x,ic);
yd= filter(num,denom,xd,ic);
d=y-yd(1+D:41+D);
figure(1);
stem(n,y);
ylabel('Amplitude');
title('output y[n]');grid;
figure(2);
stem(n,yd(1:41));
title('output yd[n]');grid;
figure(3);
stem(n,d);
title('output d[n]');grid;

