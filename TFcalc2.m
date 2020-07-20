%calculate tf => y[n] = x[n]x[n-1]
%   input signal x
n = 0:40;
x =  cos(2*pi*0.1*n);
x1= [0 x 0];%x[n]
x2= [x 0 0];%x[n-1]
y = x.*x;
figure(1);
plot(y);
title('x[n]x[n-1] output');
xlabel('time index n'); ylabel('Amplitude');