% Generate OFDM Waveform
genOFDMPacket;
% Add random offset
offset = randi([0 1e2]);
y = [zeros(offset, 1);y];

% schidl and Cox: Coarse Packet Detection
L = 16; % Short sync field length
m = L; % Distance between fields
N = 300; % Autocorrelation samples
M = zeros(N,1);
SNR = [20];
for SNRindx = 1:length(SNR)
    r = awgn(y, SNR(SNRindx), 'measured');
    %Determine timing metric
    for K=1:N
        p = r(K:K+m)' * r(K+L:K+m+L);
        a = abs(y(K+L:K+m+L));
        R = a'*a;
        M(K) = abs(p)^2/(R^2);
    end
    % plot
    subplot(length(SNR), 1, SNRindx); stem(M);
    hold on; stem(offset + 1, M(offset + 1),'r*'); hold off;
    grid on; xlabel('k'); ylabel('M');
    legend('Autocorrelation', 'True Start');
    title(['SNR: ', num2str(SNR(SNRindx)), 'dB']);
end

%{

%}