%Generation of swept frequency sinusoidal sequence
n = 0:100;
a = pi/2/100;
b = 0;
arg = a*n .*n + b*n;
x = cos (arg);
clf;
stem(n,x);
axis([1,100,-1.5,1.5]);
title('Swept-frequency Sinusoidal signal');
xlabel('Time index n');
ylabel('Amplitude');
grid;
axis;