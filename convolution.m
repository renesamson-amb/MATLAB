%convolution using conv command
clf;
h = [3 2 1 -2 1 0 -4 0 3]; %impulse response
x = [1 -2 3 -4 3 2 1]; %input sequence
y = conv(h,x);
n = 0:14;
figure(1);
stem(n,y);
xlabel('Time index n');ylabel('Amplitude');
title('Output obtained by convolution');grid;
x1 = [x zeros(1,8)];
y1 = filter(h,1,x1); %filtering also gives same output as convolution 
%provided the numerator is the impulse response
figure (2);
stem(n,y1);
xlabel('Time index n'); ylabel('Amplitude');
title('Output obtained by filtering');grid;
 