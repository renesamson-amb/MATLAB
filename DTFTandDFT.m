%   DFT is the samples of DTFT calculated for every N points
%   circular convolution is the modulo N convolution of two signals
%   g[(n-n0)modN) = WN^kn0 * G[k];
%   time shift is given by multiplication of frequency component of 
%   signal
%   multiplication of a specific frequency component in the time domain 
%   corresponds to modulo N shifting of signal in frequency domain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%following program is the computation of DTFT
clf;
w = -4*pi:8*pi/511:4*pi;
num = [2 1]; den = [1 0 -0.6];
h = freqz(num,den,w);

%real part of DTFT
figure(1);
plot(w/pi,real(h));grid;
title('Real part of H(e^{j/omega})');
xlabel('\omega /\pi');
ylabel('Amplitdue');

%imaginary part of DFT
figure(2);
plot(w/pi, imag(h));grid;
title('imag part of (H(e^{j/omega}))');
xlabel('\omega \/pi');
ylabel('Amplitude');

%magnitude spectrum
figure(3);
plot(w/pi, abs(h));grid;
title('magnitude spectrum');
xlabel('\omega \/pi');
ylabel('Amplitude');

%phase spectrum
figure(4);
plot(w/pi, angle(h));grid;
title('Phase spectrum');
xlabel('\omega \/pi');
ylabel('Amplitude');

%program Q3.3
%zeros = 0.7  -0.5 0.3 1
%poles = 1 0.3 -0.5 0.7
w1 = 0:8*pi/511:pi;
num1 = [0.7  -0.5 0.3 1];
den1 = [1 0.3 -0.5 0.7];
h1 = freqz(num1,den1,w1);



figure (15);
plot(w1/pi,real(h1));grid;
xlabel('Real part of H(e^{j\omega})');ylabel('Amplitude');

figure(16);
plot(w1/pi,imag(h1));grid;
xlabel('Imaginary part of H(e^{j\omega})');ylabel('Amplitude');

figure(17);
plot(w1/pi,abs(h1));grid;
xlabel('magnitude spectrum H(e^{j\omega})'); ylabel('Amplitude');

figure(18);
plot(w1/pi,angle(h1));grid;
xlabel('phase spectrum of H(e^{j\omega})');ylabel('Amplitude');






