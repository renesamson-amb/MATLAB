%DFT part 2
clf;
w = -4*pi: pi/255: 4*pi; %frequency range
num = [1 3 5 7 9 11 13 15 17]; %numerator
h = freqz(num,1, w);
%plot the real part of h
figure(1);
plot(w/pi,real(h));grid;
title('real part of h(e^{j\omega})');ylabel('Amplitude');
xlabel('\omega /\pi');
%plot the imag part of h
figure(2);
plot(w/pi,imag(h));grid;
title('imag part of h(e^{j\omega})');ylabel('Amplitude');
xlabel('\omega /\pi');
%plot the mag of h
figure(3);
plot(w/pi,abs(h));grid;
title('magnitude of h(e^{j\omega})');ylabel('Amplitude');
xlabel('\omega /\pi');
%plot the phase of h
figure(4);
plot(w/pi,angle(h)*180/pi);grid;
title('Phase spectrum of h(e^{j\omega})');xlabel('\omega / \pi');
ylabel('\theta');
