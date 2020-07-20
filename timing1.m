dbpskmod = comm.DBPSKModulator(pi/4);
dpbpskdemod = comm.DBPSKDemodulator(pi/4);
errorRate = comm.ErrorRate('ComputationDelay', 1);
Fs = 1000;
for counter = 1:(1/Fs):1-(1/Fs)
    txdata  = randi([0,1], 50,1);
    modsig = dbpskmod(txdata);
    rxsig = awgn(modsig, 7);
    rxdata = dpbpskdemod(rxsig);
    errorStats = errorRate(txdata, rxdata);
end    
figure(1);
plot(modsig); 
title('Modulated DBPSK signal');

figure(2);
plot(rxsig);
title('AWGN passed DBPSK signal');



X = fft(modsig);

figure(3);
plot(X);
title("Fourier transform of a signal");

N = length(X);
xdft = X(1:N/2 + 1);
psdx = (1/(Fs*N)) * abs(xdft).^2;

figure(4);
plot(psdx);
title('PSD');

%rcosdesign -paramters 
%rolloff, span-no. of samples, smples per second, 'normal'
rf = rcosdesign(0.33, 4, 10,'normal');
out = conv(modsig, rf);
X1 = fft(out);

N = length(X1);
xdft = X1(1:N/2 + 1);
psdx = (1/(Fs*N)) * abs(xdft).^2;


figure(5);
plot(X1);
title('after SRRC filter');




