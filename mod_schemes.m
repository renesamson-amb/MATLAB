%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sending binary data via sinusoidal signal

%parameters
sig_len = 1000; %signal length
sample_per_bin = 100;
bin_data_len = sig_len / sample_per_bin;
bin_data = round(rand(1,bin_data_len));

%create sinusoidal carriers
%sample_per_bin = 100
sig_carrier_base = sin(2*pi*(0:(1/sample_per_bin):(1-(1/sample_per_bin))));

sig_carrier_freq = sin(4*pi*(0:(1/sample_per_bin):(1-(1/sample_per_bin))));

sig_carrier_phase = sin(2*pi*(0:(1/sample_per_bin):(1-(1/sample_per_bin)))+(pi/4));
%empty vectors created for binary stream,ask,fsk and psk
sig_bin = [];%binary waveform 
sig_ask = [];%amplitude waveform
sig_psk = [];%psk waveform
sig_fsk = [];%fsk waveform
for ind = 1:1:bin_data_len %bin_data_len = 10
    if(bin_data(ind)==1)
        sig_bin = [sig_bin ones(1,sample_per_bin)];
        sig_ask = [sig_ask sig_carrier_base];
        sig_psk = [sig_psk sig_carrier_base];
        sig_fsk = [sig_fsk sig_carrier_base];
    else
        sig_bin = [sig_bin zeros(1,sample_per_bin)];
        sig_ask = [sig_ask 0.5*sig_carrier_base];
        sig_psk = [sig_psk sig_carrier_phase];
        sig_fsk = [sig_fsk sig_carrier_freq];
    end
end

figure(1);
plot(sig_bin);
title('signal stream');
figure(2);
plot(sig_ask);
title('signal ASK');
figure(3);
plot(sig_psk);
title('signal PSK');
figure(4);
plot(sig_fsk);
title('signal FSK');