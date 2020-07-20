% channel estimation
sync3;
r = awgn(y(offset+1:end),15, 'measured'); 
%received signal through AWGN channel
r = pfOffset(r);
preambleOFDMMod = comm.OFDMModulator(...
    'FFTLength', FFTLength, ...
    'NumGuardBandCarriers', NumGuardBandCarriers,...
    'CyclicPrefixLength', 0, 'NumSymbols', 2, 'InsertDCNull', true);
od = comm.OFDMDemodulator(preambleOFDMMod);
od.PilotOutputPort = true;
LLTF = Preamble(161:161+160-1); rLLTF = r(161+32:161+160-1);
[rLLTFFreq,rp] = od(rLLTF); [LLTFFreq, p] = od(LLTF(33:end)); %remove CP
% Estimate Channel
ls = rLLTFFreq./LLTFFreq; %Least-square estimate
chanEst = mean(ls, 2); %average over both symbols
CSI = real(chanEst.*conj(chanEst));
ls = rp./p; %Least-square estimate
chanEstPilots = mean(ls, 1); %Average over both symbols
CSIPilots = real(chanEstPilots.*conj(chanEstPilots));
% Perform Equalization
data = r(2*length(LLTF)+1:end);
odd = comm.OFDMDemodulator(DataOFDMMod);
[dataFreq,pilots] = odd(data);
% Apply LLTF's estimate to data symbols and data pilots
postLLTFEqData = bsxfun(@times, dataFreq, conj(chanEst(:))./CSI(:));
postLLTFEqPilots = ...
    bsxfun(@times, pilots, conj(chanEstPilots(:))./CSIPilots(:));
% Visualiztion objects
tt1 = comm.ConstellationDiagram; tt2 = commConstellationDiagram;
tt2.Position = tt2.Position+[500 0 0 0];
% Esimate remaining offsets with pilots
correctSymbols = [zeros(size(postLLTFEqData))];
for symbol = 1: size(postLLTFEqData, 2)
    % Estimate rotation across pilots
    p = postLLTFEqPilots(:,symbols);
    e = conj(mean(p.*conj(Pilots(:,symbol))));
    % Equalize
    sig = postLLTFEqData(:,symbol).*e;
    correctedSymbols(:,symbol) = sig;
    tt1(sig); tt2(postLLTFEqData(:,symbol)); pause(0.1)
end
