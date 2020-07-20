%next tutorial
clf;
L = 1000000;
res_hist = 100; %histogram resolution
cuttoff_freq1 = 0.2;    %small passband LPF    
cuttoff_freq2 = 0.7;    %large passband LPF

filt_coeffs1 = firls(13,[0 cuttoff_freq1 cuttoff_freq1+ 0.02 1],[1 1 0 0]);
%firls(n,f,a);
%n -> is the order of filter
%f ->is the frequency vector points between 
%0 and 1, 1 corresponds to
%nyquist frequency
%a corresponds to desired amplitdue at specified
%points in f
filt_coeffs2 = firls(12,[0 cuttoff_freq2 cuttoff_freq2+ 0.02 1],[1 1 0 0]);

%create input 2d gaussian random variable
x_in_phase = rand(1,L);%uniform random variable
x_q_phase = rand(1,L);%

%filter input random data stream
filt_output1 = filter(filt_coeffs1,1,(x_in_phase+1j.*x_q_phase));
x_in_out1 = real(filt_output1);
x_q_out1 = imag(filt_output1);
figure(1);


Z = x_in_out1.*x_q_out1;

%surf(x_in_out1,x_q_out1,Z);
%title('contour plot of FIR filter1');
%employ the second filter
filt_output2 = filter(filt_coeffs2,1,(x_in_phase+1j.*x_q_phase));
x_in_out2 = real(filt_output2);
x_q_out2 = imag(filt_output2); 

figure(1);
plot(x_in_out1);
hold on;
plot(x_q_out1);
hold off;
title('filter 1');

figure(2);
plot(x_in_out2);
hold on;
plot(x_q_out2);
hold off;
title('filter 2');

