%decoding QAM waveforms using I/Q samples

%define parameters
N_samp = 1000;
N_symb = 10;
cfreq = 0.1;

%generate inphase and  quadrature signals
chI = 2*round(rand(1,N_symb)) -1;
chQ = 2*round(rand(1,N_symb)) -1;
samp_i = [];
samp_q = [];
for ind = 1:1:N_symb
    samp_i = [samp_i chI(ind)*ones(1,N_samp)];
    samp_q = [samp_q chQ(ind)*ones(1,N_samp)];
end

tx = samp_i.*cos(2*pi*cfreq.*(1:1:length(samp_i))) + samp_q.*sin(2*pi*cfreq.*(1:1:length(samp_q)));

figure(1);
plot(tx);
title('binary QAM');
