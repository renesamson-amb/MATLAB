%   Q1.26 Random signal of length N= 100;
%   distributed equally in the interval [-2,2];
N = 100;
%r = -2:1/0.04:2;
x = 4.*rand(N,1) - 2;
figure(1);
plot(x);grid;
%axis([-2 2 -20 20]);
title('random signal');

%specific mean and variance
SD = 3;%var is SD^2
mean = 0;
var = SD^2;
y= mean.*randn(N,1)+var;
%note the different randn command used
figure(2);
plot(y);grid;
title('random signal with 0 mean and var 9');


%   matlab program to generate and 
%   display five sequences of a random 
%   signal of length 31
len=0:31;
freq=0.4;
A=4.*rand(1,5)+0;
phase=(2*pi).*rand(1,5)+0;
%generate 5 cosine waves cosine wave
%first
figure(3);
x2=A(1,1)*cos(2*pi*len*freq + phase(1,1));
plot(x2);
%second
figure(4);
x3=A(1,2)*cos(2*pi*len*freq + phase(1,2));
plot(x3);
%third
figure(5);
x4=A(1,3)*cos(2*pi*len*freq + phase(1,3));
plot(x4);
%fourth
figure(6);
x5=A(1,4)*cos(2*pi*len*freq + phase(1,4));
plot(x5);
%fifth
figure(7);
x6=A(1,5)*cos(2*pi*len*freq + phase(1,5));
plot(x6);

