%comm2.8 eye diagram
%creates impulse train of period L and length len with random
%+/- one values
L = 10;
impulse_num = 100; %TOtal number of impulses in impulse train
len = L* impulse_num;
temp1 = [2*round(rand(impulse_num,1))-1 zeros(impulse_num,L-1)];
x_impulse = reshape(temp1.',[1,L*impulse_num]);
%create two transmit filter pulse shapes of order L
%approximate rectangualr frequency response 
%sinc(x) impulse response
txfilt1 = firls(L,[0 0.24 0.25 1],[4 4 0 0]);
%approximate triangular frequency response -->approximate
txfilt2 = firls(L,[0 0.5 0.52 1] ,[4 0 0 0]);
%pulse shape impulse train
y_impulse1 = filter(txfilt1,1,x_impulse);
y_impulse2 = filter(txfilt2,1,x_impulse);
figure(14);
plot(y_impulse1);
title('impulse response for FIR filter 1');
figure(15);
plot(y_impulse2);
title('impulse response for FIR filter 2');
%eyediagram(x,n,period,offset)
%create an eye diagram for signal x, plotting n samples
%trace horizontally axis range between -period/2 and period/2
eyediagram(y_impulse1,L,L,floor(L/2));
eyediagram(y_impulse2,L,L,floor(L/2));

%code 2.9
eyediagram((y_impulse1+0.1*randn(1,length(y_impulse1))),L,L,floor(L/2));
eyediagram((y_impulse2+0.1*randn(1,length(y_impulse1))),L,L,floor(L/2));




