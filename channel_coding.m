%define parameters
%incomplete =------- to be completed
len = 1000000;
N1 =3; N2 = 5; N3 = 7;

%generate bit stream 
bin_str = round(rand(1,len));%has 1 and 0 of length 100000

%employ repetition code with repetition factors N1,N2,N3
chcode1_bin_str = zeros(1,N1*len);
chcode2_bin_str = zeros(1,N2*len);
chcode3_bin_str = zeros(1,N3*len);

%imbue these codes in the binary string
for ind = 1:1:max([N1 N2 N3])
    if(ind<=N1)
        chcode1_bin_str(ind:N1:(N1*(len-1)+ind)) = bin_str;
    end 
    if(ind<=N2)
        chcode2_bin_str(ind:N2:(N2*(len-1)+ind)) = bin_str;
    end
    if(ind<=N3)
        chcode3_bin_str(ind:N3:(N3*(len-1)+ind)) = bin_str;
    end
end
%noise followed by rounding (creates *bit flipping* errors)
noisy_bin_str = bin_str+randn(1,len);
rx_bin_str0 = zeros(1,len);
ind0 = find(noisy_bin_str >= 0.5);
rx_bin_str(ind0) = 1;
noisy_chcode_bin_str = chcode1_bin_str +randn(1,N1*len);
rx_chcode_bin_str = zeros(1,N1*len);
ind1 = find(noisy_chcode1_bin_str) >= 0.5);
rx_chcode_bin_str(ind1) = 1;
noisy_chcode2_bin_str = chcode2_bin_str + randn(1,N2*len);
rx_chcode2_bin_str = zeros(1,N2*len);
ind2 = find(noisy_chcode2_bin_str >= 0.5);
rx_chcode2_bin_str(ind2) = 1;
noisy_chcode3_bin_str1

