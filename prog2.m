%program for source coding 
%reduce redundancy
%have two ;binary sources, one in 50/50 1s and 0s
%other with 90/10 1s and 0s
len = 10000;
bin1 = round(rand(1,len));
bin2 = round(0.5*rand(1,len) + 0.45);

enc_bin1 = [];
enc_bin2 = [];

for ind = 1:1:len
    if(bin1(ind) ==1) %Encoding 50/50
        if(ind == 1)
            enc_bin1 = 1;
        else
            enc_bin1(end) = enc_bin1(end)+ 1;
        end
    else
        enc_bin1 = [enc_bin1 0];
    end
    if(bin2(ind) == 1) %encoding 90/10
        if(ind == 1)
            enc_bin2 = 1;
        else
            enc_bin2(end) = enc_bin2(end)+1;
        end
    else
        enc_bin2 = [enc_bin2 0];
    end
end

%Find size of encoded binary streams
%(assume all one string length values posses the same number of bits)
ind1 = find(enc_bin1 ~= 0);
ind2 = find(enc_bin2 ~= 0);
%finding the largest and the corresponding number of indexes
[largest_ebin1,ind_largest_ebin1] = max(enc_bin1(ind1));
[largest_ebin2,ind_largest_ebin2] = max(enc_bin2(ind2));
%converting the binary values of largest_ebins 
%coverting them to numbstring by subtracting by 0
%finding the length
numbits1 = length(dec2bin(largest_ebin1)-'0');
numbits2 = length(dec2bin(largest_ebin2)-'0');
%Total number of bits sent
total_size_ebin1 = length(ind1)*numbits1 + length(find(enc_bin1 == 0));
total_size_ebin2 = length(ind2)*numbits2 + length(find(enc_bin2 == 0));
%taking the size of the largest binary stream to 
%match every possible 1 sequences



%do the same for 70/30 bit source
len = 10000;

bin3 = round(0.5*rand(1,len) + 0.25); %just an approximation

enc_bin3 = [];

for ind = 1:1:len
    if(bin3(ind) == 1)
        if(ind == 1)
            enc_bin3 = 1;
        else
            enc_bin3(end) = enc_bin3(end) + 1;
        end
    else
        enc_bin3 = [enc_bin3 0];
    end
end

ind3 = find(enc_bin3 ~= 0);
%find the largest
[largest_ebin3,largest_ebin3_ind] = max(enc_bin3(ind3));
%convert to binary string and find its length
numbits3 = length(dec2bin(largest_ebin3) - '0');
%find the total size
total_size_ebin3 = length(ind3)*numbits3 + length(find(enc_bin3 ==0));
display(total_size_ebin3);
%%tecnique for displaying if the encoding is 
%%working or not
if(total_size_ebin3 > len)
    display('waste');
else
    display('excellent');
end

