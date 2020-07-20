%create deterministic and stochastic digital data streams
Fsl = 10;
taps = 3;
n = 0:1/Fsl:100-(1/Fsl);    %time index vector
sin_wave = sin (5*n*2*pi);  %Genertaion of sinusoidal signal

random = 2*round(rand(1,length(n)))-1; %random string of  +1 and -1 values
%create low pass filter and apply it to both data streams
%b = firls(n,f,a);
%n is the FIR filter coefficient
%f is a vector of paris of frequency points
%a is a vector containing the desired amplitude at the points in f

coeffs1 = firls(taps,[0 0.2 0.22 1],[1 1 0 0]); %FIR filter coefficients

sin_bwlimited = filter(coeffs1, 1, sin_wave);
random_bwlimited = filter(coeffs1,  1, random);

figure(1);
plot(sin_bwlimited);
title('deterministic');
figure(2);
plot(random_bwlimited);
title('Random');


%y = upsample(x,n)
%   x is the signal, n is the interpolation rate
%   between samples
%   results in compression of frequency spectrum
%   wy= wx/n; wy=> frequency of upsampled signal
%   wx=> frequency of original signal

N=5;
sin_up = upsample(sin_bwlimited, N);
random_up = upsample(random_bwlimited,N);
figure(3);
plot(sin_up);
title('upsampled sin wave');
figure(4);
plot(random_up);
title('upsampled random wave');

%code 2.6 
%   Note the upsampled signal is downsampled here
%   The original signal is not used
M=3;
%sin_down = downsample(sin_up, M);
%figure(5);
%plot(sin_down);
%title('downsampled sine wave');
%random_down = downsample(random_up, M);
%figure(6);
%plot(random_down);
%title('downsampled random wave');

%code 2.7
%   lowpass filtering of baseband periodic replica followed by
%   downsampling
%   (correct approach)
coeffs2 = firls(taps, [0 0.15 0.25 1], [N N 0 0]);

sin_up_filtered = filter(coeffs2,1, sin_up);
sin_up_filtered_down = downsample(sin_up_filtered, M);
random_up_filtered = filter(coeffs2, 1, random_up);
random_up_filtered_down = downsample(random_up_filtered, M);
figure (5);
plot(sin_up_filtered_down);
title('sin upsampled filtered downsampled');
figure(6);
plot(random_up_filtered_down);
title('random upsampled filtered downsampled');
