%just testing
%a asymetrical channel model
%clf;
L = 10000;
prob00 = 0.95;
prob11 = 0.99;
prob4c = 0.7; %70% 1s and 30%0s

% binary information for sending
tx_original = round(0.5*rand(1,L)+ 0.5*prob4c);
tx = tx_original; %save the original stream for later
%randomly select 1 and 0
ind_one = find(tx == 1);
%randomly select locations out of ind_one
%and flip it to 0
ind_one_rx = find(round(0.5*rand(1,length(ind_one))+ 0.5*(1-prob11)) == 1);
%do the above steps for bit 0s
ind_zero = find(tx ==0);
%flip the same
ind_zero_rx = find(round(0.5*rand(1,length(ind_zero))+ 0.5*(1-prob00))== 1);

%flip those instances
tx(ind_zero(ind_zero_rx)) = 1;
tx(ind_one(ind_one_rx)) = 0;

%calculate bit error rate
%using the originally received and later received
b_error_total = sum(abs(tx-tx_original))/L;
b_error_1s = sum(abs(tx_original(ind_one)-tx(ind_one)))/length(ind_one);
b_error_0s = sum(abs(tx_original(ind_zero)-tx(ind_zero)))/length(ind_zero);

%plot the values
fprintf("\nBER = %d\nBER_1 = %d\nBER_0 = %d\n",b_error_total,b_error_1s,b_error_0s);



