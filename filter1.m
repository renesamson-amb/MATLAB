%moving average with only past values
clf;
n = 0:100;
s1 = cos(2*pi*0.05*n); % A low frequency sinusoid
s2 = cos(2*pi*0.05*n);
x = s1 + s2;
% M = input('Desired length of the filter = ');
num = [1 -1]; %for M =2 
y = filter(num,1,x)/2;  %TF becomes x[n]+x[n-1]/2
%filter command
%filter (num,denom,input);
%in the above command the output is normalized by M
%<--------------------------------->
%DISPLAY THE INPUT AND OUTPUT SIGNAL
figure(1);
plot(n,s1);
axis([0, 100, -2,2]);
xlabel('Time index n');ylabel('Amplitude');
title('Signal #1');
%DISPLAY SECOND FIGURE
figure(2);
plot(n,s2);
axis([0,100,-2,2]);
xlabel('Time index n');ylabel('Amplitude');
title('Signal #2');
%DISPLAY THE COMBINED SIGNAL
figure(3);
plot(n,x);
axis([0,100,-2,2]);
xlabel('Time Index n');ylabel('Amplitude');
title('signal #3');
%DISPLAY FILTERED SIGNAL
figure(4);
plot(n,y);
axis([0,100,-2,2]);
xlabel('Time Index n');ylabel('Amplitude');
title('Signal 4');
