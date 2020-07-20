%source encoding
len = 100000;

%have two binary sources, one 50/50 and the other 90/10 in terms of
%number of ones and zeros

bin1 = round(rand(1,len));%50/50 binary
bin2 = round(0.5*rand(1,len)+0.45);%95/5 1s

%encode strings of ones in terms of length of these string
enc_bin1 = [];
enc_bin2 = [];
for ind = 1:1:len
    if(bin1(ind) == 1) %encoding 50/50
        if(ind ==1) %if its the first position
            enc_bin1 = 1; %
        else
            enc_bin1(end)=enc_bin1(end)+1;
        end
    else
        enc_bin1 = [enc_bin1 0];
    end
    if(bin2(ind)==1) %encoding 95/5
        if(ind==1)
            enc_bin2 = 1;
        else
            enc_bin2(end) = enc_bin2(end)+1;
        end
    else
        enc_bin2 = [enc_bin2 0];
    end
end
% take all the 1 bits
ind1 = find(enc_bin1 ~= 0);
ind2 = find(enc_bin2 ~= 0);
% max returns the maximum number of elements in a array
[largest_ebin1,ind_largest_ebin1] = max(enc_bin1(ind1));
[largest_ebin2,ind_largest_ebin2] = max(enc_bin2(ind2));
% dont know the significance of largest_ebin1 and ind_largest_ebin1
numbit1 = length(dec2bin(largest_ebin1)-'0');
numbit2 = length(dec2bin(largest_ebin2)-'0');

total_size_ebin1 = length(ind1)*numbit1 + length(find(enc_bin1 == 0));
total_size_ebin2 = length(ind2)*numbit2 + length(find(enc_bin2 == 0));

disp(total_size_ebin1);
disp(total_size_ebin2);
            
        
