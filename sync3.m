% Estimate fine sample offset
sync2;
offset = randi([0 1e2]); y = [zeros(offset,1);y];
SNR = 0; r = awgn(y,SNR,'measured');
LSTF = Preamble(1:160);
LLTF = Preamble(161:161+160-1);
symLen = 80; %FFTLength + CPLen
known = LLTF(1:symLen, 1);
% Filter
coeff = conj(flipud(known));
c_filt = abs(filter(coeff, 1, r)).^2;
% correlation
m = abs(xcorr(r, known)).^2;
padding = length(r)-symLen+1; 
c_cor = m(padding:end);
[v1, peak1] = max(c_cor);
c_cor(peak1) = 0;
[v2, peak2] = max(c_cor);
% get numerical offset
if abs(peak2-peak1) == FFTLength
    % Adjust position from start of LLTF
    p = min([peak1 peak2]);
    LLTF_Start_est = p-symLen;
    LSTF_Start_est = LLTF_Start_est - length(LSTF);
    % Display
    disp([offset LSTF_Start_est]);
end
