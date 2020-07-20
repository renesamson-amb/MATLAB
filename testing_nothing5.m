%define parameters
len = 100000;
nvar= 0.15;

%generate the random bit streams that have already been demultiplexed
bin_str1 = round(rand(1,len));
bin_str2 = round(rand(1,len));

%perform mapping of bits to symbols
ind_wavefm  = 2.*bin_str2 + bin_str1;
%waveform
wavefm_4pam = zeros(1,len); %4-PAM
wavefm_4qam = zeros(1,len) ; %4-QAM
wavefm_qpsk = zeros(1,len); %QPSK
%symbols
symb_4pam = [-3 -1 3 1];
symb_4qam = [-1+i 1+i 1-i -1-i];
symb_qpsk = [ exp(i*(pi/5+pi/2)) exp(i*(pi/5+pi)) exp(i*(pi/5)) exp(i*(pi/5+3*pi/2)) ];

for ind = 1:1:4 %method of cutting the amplitude into 4
    wavefm_4qam(find(ind_wavefm == (ind-1))) = symb_4qam(ind);
    wavefm_4pam(find(ind_wavefm == (ind-1))) = symb_4pam(ind);
    wavefm_qpsk(find(ind_wavefm == (ind-1))) = symb_qpsk(ind);
end


%add complex zero-mean white gaussian noise
noise_signal = (1/sqrt(2))*sqrt(nvar)*randn(1,len)+i*(1/sqrt(2))*sqrt(nvar)*randn(1,len);
rx_wavefm_4pam = wavefm_4pam + noise_signal;
rx_wavefm_4qam = wavefm_4qam + noise_signal;
rx_wavefm_qpsk = wavefm_qpsk + noise_signal;


%go through every received waveform and determine euclidean
%distance between received waveform and the available waveform
eucl_dist_4pam = zeros(4,len);
eucl_dist_4qam = zeros(4,len);
eucl_dist_qpsk = zeros(4,len);

for ind= 1:1:4
    eucl_dist_4pam(ind,1:1:len) = abs(symb_4pam(ind).*ones(1,len) -rx_wavefm_4pam);
    eucl_dist_4qam(ind,1:1:len) = abs(symb_4qam(ind).*ones(1,len) -rx_wavefm_4qam);
    eucl_dist_qpsk(ind,1:1:len) = abs(symb_qpsk(ind).*ones(1,len) -rx_wavefm_qpsk);
end

%select shortest euclidean distance
[mdist_4pam,min_ind_4pam] = min(eucl_dist_4pam);
[midst_4qam,min_ind_4qam] = min(eucl_dist_4qam);
[midst_qpsk,min_ind_qpsk] = min(eucl_dist_qpsk);

%decode into estiated binary stremas
bin_str_est_4pam = dec2bin(min_ind_4pam-ones(1,len)).';
bin_str_est_4qam = dec2bin(min_ind_4qam-ones(1,len)).';
bin_str_est_qpsk = dec2bin(min_ind_qpsk-ones(1,len)).';

%calculate the bit error rate
ber_pam  =sum([abs((bin_str_est_4pam(1,:)-'0')-bin_str2) ...
        abs((bin_str_est_4pam(2,:)-'0') - bin_str1)])/(2*len);
ber_qam  =sum([abs((bin_str_est_4qam(1,:)-'0')-bin_str2) ...
        abs((bin_str_est_4qam(2,:)-'0') - bin_str1)])/(2*len);
ber_qpsk  =sum([abs((bin_str_est_qpsk(1,:)-'0')-bin_str2) ...
        abs((bin_str_est_qpsk(2,:)-'0') - bin_str1)])/(2*len);
    
%figure(1);
%%imhist(ber_pam);
%hold on;
%imhist(ber_qam);
%hold on;
%imhist(ber_qpsk);

disp(ber_pam);
disp(ber_qam);
disp(ber_qpsk);