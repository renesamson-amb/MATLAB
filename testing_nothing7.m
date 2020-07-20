%Define parameters
N_symb = 10;
%%%%%code 4.8%%%%%%%%%%%%% 
%Randomly generate intercepted waveform of s1(n),s2(n),
%s3(n) and s4(n)
N_samp= 1000;
%
rx_sig = [];
orig_mag = 1:1:N_symb;
for ind = 1:1:N_symb
    rnd_val = rand(1,1);
    if(rnd_val < 0.25) %add s1(n) waveform
        rx_sig = [rx_sig sig_s1];
        orig_mag = [orig_mag 1];
    elseif ((rnd_val >= 0.25) && (rnd_val <=0.5))
        rx_sig = [rx_sig sig_s2];
        