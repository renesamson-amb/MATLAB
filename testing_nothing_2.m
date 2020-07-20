len = 1000;

%create channels
ch1 = round(rand(1,len)); %50/50 1s channel
ch2 = round(0.5*rand(1,len)+0.4);%90/10 1s channel

%encoding stream
enc_bin1 = [];
enc_bin2 = [];

for ind = 1:1:len
    if(ch1(ind) == 1)
       if(ind ==1)
        enc_bin1 = [enc_bin1 1];
       else
        enc_bin1(end) = enc_bin1(end)+1;
       end
    else
        enc_bin1 = [enc_bin1 0];
    end
    if(ch2(ind) ==1)
        if(ind ==1)
            enc_bin2 = [enc_bin2 1];
        else
            enc_bin2(end) = enc_bin2(end)+1;
        end
    else
        enc_bin2 = [enc_bin2 0];
    end
end

%find size of encoded streams
ind1 = find(enc_bin1 ~= 0);
ind2 = find(enc_bin2 ~= 0);

[largest_ebin1, ind_largest_ebin1] = max(enc_bin1(ind1));
[largest_ebin2, ind_largest_ebin2] = max(enc_bin2(ind2));

numbits1 = length(dec2bin(largest_ebin1) -'0');
numbits2 = length(dec2bin(largest_ebin2) -'0');

total_size_ebin1 = length(ind1)*numbits1 + length(find(enc_bin1 == 0));
total_size_ebin2 = length(ind2)*numbits2 + length(find(enc_bin2 == 0));

disp(total_size_ebin1);
disp(total_size_ebin2);

