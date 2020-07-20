%impulse response of following LTI system
%first 45 samples printed
%y[n] + 0.71y[n-1] -0.46y[n-2]-0.62y[n-3] =
%           0.9x[n] - 0.45x[n-1] + 0.35x[n-2] +0.002x[n-3]
clf;
N  = 45;
num = [0.9 -0.45 0.35 0.002];
den = [1 -0.7  -0.46 -0.62];
y = impz(num,den,N);
%   impz(num,denom,N)
%   num => zeros of TF
%   denom =>poles of TF
%   N => the number of impulse response points
figure(1);
stem(y);
title('impulse response with impz command');
xlabel('time index n'); ylabel('Amplitude');
%impulse response generated using filter command
x = [1 zeros(1,44)];%impulse i guess
y1 = filter(num,den,x);
figure(2);
stem(y1);
title('impulse response with filter command');
xlabel('time index n');ylabel('Amplitude');


