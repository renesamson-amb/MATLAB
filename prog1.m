sig_len = 1000;
sample_per_bin = 100;
bin_data_len = 10; %the amount of binary data
%generating binary data
bin_data = round(rand(1,bin_data_len));
%create base carrier, amplitude, phase and frequency
base_carrier = sin(2*pi*(0:(1/sample_per_bin):(1-(1/sample_per_bin)))); %baseline Carrier
sig_carrier_freq = sin(2*2*pi*(0:(1/sample_per_bin):(1-(1/sample_per_bin)))); %frequency
sig_carrier_phase = sin(2*pi*(0:(1/sample_per_bin):(1-(1/sample_per_bin))) + (pi/4));

%modulated carrier
sig_bin = []; %binary waveform
sig_ask = []; %amplitude modulated
sig_psk = []; %phase modulated
sig_fsk = []; %frequency modulated

for ind = 1:1:bin_data_len
    if(bin_data(ind) == 1)
        sig_bin = [sig_bin ones(1,sample_per_bin)];
        sig_ask = [sig_ask base_carrier];
        sig_psk = [sig_psk base_carrier];
        sig_fsk = [sig_fsk base_carrier];
    else
        sig_bin = [sig_bin zeros(1,sample_per_bin)];
        sig_ask = [sig_ask 0.5*base_carrier];
        sig_psk = [sig_psk sig_carrier_phase];
        sig_fsk = [sig_fsk sig_carrier_freq];
    end
end

figure(1);
plot(sig_bin);
title('binary stream');

figure(2);
plot(sig_ask);
title('amplitude shift keying');

figure(3);
plot(sig_psk);
title('phase shift keying');

figure(4);
plot(sig_fsk);
title('frequency shift keying');

