%BER assessment
L = 100000;%transmission length
prob00 = 0.95;
prob11 = 0.99;
prob4 = 0.7; %70%1s and 30%0s;

%create data for transmission
b4 = round(0.5*rand(1,L)+0.5*prob4);

b4hat = b4;%initialize receive binary data

%mimic the action of channel by randomly selecting and
%flipping 1s and 0s
%randomly select 1 and 0 values for flipping
ind_zero = find(b4 ==0);
ind_one = find(b4 ==1);
ind_flip_zero = find(round(0.5*rand(1,length(ind_zero))+0.5*(1-prob00))== 1); 
ind_flip_one = find(round(0.5*rand(1,length(ind_one))+0.5*(1-prob11)) == 1);

%corrupt received binary data stream
b4hat(ind_zero(ind_flip_zero))=1; %flip 0 to 1
b4hat(ind_one(ind_flip_one))=0; %flip 1 to 0

b4error_total = sum(abs(b4-b4hat))/L;
b4error_1 = sum(abs(b4(ind_one) - b4hat(ind_one)))/length(ind_one);
b4error_0 = sum(abs(b4(ind_zero) - b4hat(ind_zero)))/length(ind_zero);

fprintf('BER for bit 1 %f \n',b4error_1);
fprintf('BER for bit 0 %f \n',b4error_0);

