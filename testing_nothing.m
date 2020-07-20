%practising ask fsk and psk
len = 1000;
sample_per_bin = 100;
bins = len/sample_per_bin;
bin_data = round(rand(1,bins));
f = 1/sample_per_bin;

%create base carrier ask fsk and psk;
base_carrier = sin(2*pi*(0:(1/sample_per_bin):(1-(1/sample_per_bin))));
freq_carrier = sin(4*pi*(0:(1/sample_per_bin):(1-(1/sample_per_bin))));
phase_carrier= sin(2*pi*(0:(1/sample_per_bin):(1-(1/sample_per_bin)))+(pi/4));

ask = [];
fsk = [];
psk = [];
sig_bin = [];

for ind = 1:1:bins
    if(bin_data(ind) == 1)
        sig_bin = [sig_bin ones(1,sample_per_bin)];
        ask = [ask base_carrier];
        fsk = [fsk base_carrier];
        psk = [psk base_carrier];
    else
        sig_bin = [sig_bin zeros(1,sample_per_bin)];
        ask = [ask 0.5*base_carrier];
        fsk = [fsk freq_carrier];
        psk = [psk phase_carrier];
    end
end

figure(1);
title('binary data stream');
plot(sig_bin);
xlabel('time');ylabel('amplitude');

figure(2);
title('ASK');
plot(ask);
xlabel('time');ylabel('amplitude');

figure(3);
title('PSK');
plot(psk);
xlabel('time');ylabel('amplitude');

figure(4);
title('FSK');
plot(fsk);
xlabel('time');ylabel('amplitude');

        