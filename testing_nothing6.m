%define parameters
len = 10000;
N_snr = 9; %length of individual data transmissio
N_tx = 100;
nvar = [(10.^((1:1:N_snr)/10)).^(-1)]; %noise variance values

ber_data = zeros(N_snr,N_tx);
for ind = 1:1:N_snr %different SNR values
    for ind1 = 1:1:N_tx %different transmission for same SNR values
        
        %generate BPSK waveform 9we will keep this the same for each
        %SNR values for now
        tx_sig = 2*round(rand(1,len)) -1;
        
        %create additive noise
        noise_sig = sqrt(nvar(ind))*randn(1,len);
        
        %create received(noisy) signal
        rx_sig = tx_sig + noise_sig;
        
        %decode received signal back to binary
        decode_bin_str = zeros(1,len);
        decode_bin_str(find(rx_sig >= 0)) ==1;
        
        %determing and store bit error rate
        ber_data(ind,ind1) = sum(abs(decode_bin_str - (tx_sig +1)/2))/len;
    end
end
%calculate mean bit error rate and its standard deviation
mean_ber = mean(ber_data, 2).';
std_ber = std(ber_data,'',2).';

disp(mean_ber);
disp(std_ber);
        

