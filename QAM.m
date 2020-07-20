%QAM modulation and demodulation
N_samp= 1000; %samples per symbol
N_symb = 10; %number of symbols in transmission
cfreq = 1/10; %carrier frequency for QAM sine and 
%cosine
%generate inphase and quadrature channels with 2-PAM

%waveforms
ch1 = 2*round(rand(1,N_symb))-1;%in phase
ch2 = 2*round(rand(1,N_symb))-1;%quadratue

%bit stream generated
samp_I = [];
samp_Q = [];
for ind = 1:1:N_symb
    samp_I = [samp_I ch1(ind)*ones(1,N_samp)];
    samp_Q = [samp_Q ch2(ind)*ones(1,N_samp)];
end

%apply sine and cosine waves to the inphase and quadratue components
tx_sig = samp_I.*cos(2*pi.*cfreq.*(1:1:length(samp_I)))+ samp_Q.*sin(2*pi.*cfreq.*(1:1:length(samp_Q)));

%plots of I-Q samples
figure(1);
plot(tx_sig);
title('transmitted signal');


figure(2);
plot(samp_I.*cos(2*pi.*cfreq.*(1:1:length(samp_I))))
title('Inphase component');

figure(3);
plot(samp_Q.*sin(2*pi.*cfreq.*(1:1:length(samp_Q))));
title('Quadrature Component');


