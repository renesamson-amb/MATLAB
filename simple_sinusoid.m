%program to generate a simple sinusoid
f= 0.1;
n= 0:40;
phase = 0;
amp = 1.5;
arg = 2*pi*f*n - phase;
x = amp * cos(arg);
figure(1);
plot(x);grid;
title('simple sinusoid');
xlabel('Time Index');
ylabel('Amplitude');

%modification to run the sinusoid of length 50 frequency .08 and amlitude
%2.5
n2= 0:50;
freq2 = 0.08;
amp2 = 2.5;
arg2 = 2*pi *freq2*n2;
x2=amp2*cos(arg2);
figure(2);
plot(x2); grid;
title('simple sinusoid');
xlabel('Time index n');
ylabel('Amplitude');
