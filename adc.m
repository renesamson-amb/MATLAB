%program for ADC
deltat = 1e-8;
fs = 1/deltat;
t = 0:deltat:1e-5-deltat;
fundamental = 3959297;
x = 10e-3 * sin(2*pi*fundamental*t);
figure (1);
title('double precision amplitude');

r = sfdr (x,fs);%sfdr gives the 
%spurious dynamic free range
%fs is the sample rate specified
sfdr(x,fs);

bits = 2^11;
x = round(bits*sin(2*pi*fundamental*t))/bits;
figure(2);
title('full scale of fixed point amplitude');
sfdr(x,fs);


%next 
t = 0:deltat:1e-4-deltat;
x = round(bits*sin(2*pi*fundamental*t))/bits;
r = sfdr(x,fs);
figure(3);
title('increased sample rate: increased t')
sfdr(x,fs);

%not prime fundamental 
%the fundamental is a multiple of fs
fundamental = 4e6;
x = round(bits*sin(2*pi*fundamental*t))/bits;
figure(4);
r = sfdr(x,fs);
title('fundamental frequency not prime');
sfdr (x,fs);


%random signal sfdr calculation
ran = rand(1,length(t))-0.5; %randomly offset the vector by +/- 0.5
x = round(bits*sin(2*pi*fundamental*t)+ran)/bits;
figure(5);
title('random signal SFDR calculation');
sfdr(x,fs);
