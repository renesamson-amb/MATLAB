NumFrames = 1;
% Build OFDM Modulator
FFTLength = 64;
NumGuardBandCarriers = [6; 5];
NumDataCarriers = 48;
CyclicPrefixLength = 16;
PilotCarrierIndices = [12; 26;40;54];
NumOFDMSymInPreamble = 5;
NumBitsPerCharacter = 7;
% convert message to bits
msgInBits = repmat(randi([0 1], NumDataCarriers, 1), 10, 1);
PayloadBits = msgInBits(:);
% calculate number of OFDM symbols per frame
NumOFDMSymbols = ceil(length(PayloadBits)/NumDataCarriers);
% calculate number of bits padded in each frame
NumPadBits = NumDataCarriers * NumOFDMSymbols - length(PayloadBits);
% Get Preamble for each frame
Preamble = double(getOFDMPreambleAndPilot('Preamble', ...
           FFTLength, NumGuardBandCarriers));
% Get Pilot for each frame
Pilots = double(getOFDMPreambleAndPilot('Pilot', NumOFDMSymbols));
% BPSK Modulator
BPSKMod = comm.BPSKModulator;
% OFDM Modulator
DataOFDMMod = comm.OFDMModulator(...
    'FFTLength', FFTLength, ...
    'NumGuardBandCarriers', NumGuardBandCarriers, ...
    'InsertDCNull', true, ...
    'PilotInputPort', true, ...
    'PilotCarrierIndices', PilotCarrierIndices, ...
    'CyclicPrefixLength', CyclicPrefixLength, ...
    'NumSymbols', NumOFDMSymbols);
% Modulate Data
symPostBPSK = BPSKMod.step([PayloadBits; randi([0 1], NumPadBits, 1)]);
% OFDM modulation for one frame
symPostOFDM = DataOFDMMod.step(reshape(symPostBPSK, ...
    NumDataCarriers, NumOFDMSymbols), Pilots);
% Repeat the frame
y = repmat([Preamble; symPostOFDM], NumFrames, 1);