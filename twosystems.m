%   following program is a illustration for filtering
%   y[n] = 0.5x[n] + 0.27x[n-1] +0.77x[n-2]
%   y[n] = 0.45x[n] + 0.5x[n-1] +0.45x[n-2]+0.53y[n-1]-0.46y[n-2]
%   for the input 
%   x[n] = cos(20*pi*n/256)+ cos(200*pi*n/256) with 0<= n<= 299
%   300 points basically
clf;
n = 0:299;
x1 = cos(20*pi*n/256);
x2 = cos(200*pi*n/256);
x = x1+x2;
%for system 1
num1 = [0.5 0.27 0.77];
num2 = [0.45 0.5 0.45];
den2 = [1 -0.53 0.46];
%system 1 output
h1 = filter(num1,1,x);
%plot for system 1 output
figure(1);
stem(h1);
xlabel('time index n');ylabel('Amplitude');
title('system 1 output');
%system 2 output
h2 = filter(num2,den2,x);
%plot for system 2 output
figure(2);
stem(h2);
xlabel('time index n');ylabel('Amplitude');
title('system 2 output');grid;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%ans : system 2 provides better attenuation for high frequnency
%%as there are little variations in the output

