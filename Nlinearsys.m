%nonlinear Discrete time system
%y[n] = x[n]^2 - x[n-1]x[n+1]
n = 0:200;
x = cos(2*pi*0.05*n);
%compute the output signal 
x1 = [x 0 0];%x1[n] = x[n+1]
x2 = [0 x 0];%x2[n] = x[n]
x3 = [0 0 x];%x3[n] = x[n-1]
y = x2.*x2 - x1.*x3;
y = y(2:202);
%plot the input and output signals
figure(1);
plot(n,x);
xlabel('Time index n');ylabel('Amplitude');
title('input Signal');
%the second figure is for y
figure(2);
plot(n,y);
xlabel('Time index n');ylabel('Amplitude');
title('Output signal');