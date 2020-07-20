%steps for LTE decoding
%Read Raw data(I/Q) samples for 5 minutes and store in LTE.bb
%output the LTE.bb data to eNodeBOutput
%LTE command toolbox used throughout program
%Cell Search done initially assuming 1Mhz BW (6RB)  
%frequency offset estimation and correction for synchronizing the 
%USRP clock with center frequency
%OFDM demodulation
%channel estimation
%PBCH demodulation, BCH decoding, MIB parsing, to get original BW
%configuration of LTE antenna
%OFDM demodulation for entire BW.(if higher than 1MHz)
%secondary information block decoding -> gives cell ID


%initialize SDR for USRP B205 SDR
stationCenterFrequency = 850e6;
rx = comm.SDRuReceiver('Platform','B200', ...
    'CenterFrequency',stationCenterFrequency, ...
    'OutputDataType','Double', ...
    'DecimationFactor',256);


%resources specific to pluto SDR
%capture(rx,3,'Seconds','Filename','LTE.bb');
%release(rx);
eNodeBOutput = dsp.SignalSink;
%eNodeBOutput = comm.BasebandFileReader('LTE.bb');
for counter = 1:20
    data = rx;
    eNodeBOutput(data);
end

if (~exist('channelFigure','var') || ~isvalid(channelFigure))
    channelFigure = figure('Visible','off');
end
[spectrumAnalyzer,synchCorrPlot,pdcchConstDiagram] = ...
    hSIB1RecoveryExamplePlots(channelFigure,sr);
% PDSCH EVM
pdschEVM = comm.EVM();
pdschEVM.MaximumEVMOutputPort = true;

% The sampling rate for the initial cell search is established using
% lteOFDMInfo configured for (1MHz BW) 6 resource blocks. enb.CyclicPrefix is set
% temporarily in the call to lteOFDMInfo to suppress a default value
% warning (it does not affect the sampling rate).
enb = struct;                   % eNodeB config structure
enb.NDLRB = 6;                  % Number of resource blocks
ofdmInfo = lteOFDMInfo(setfield(enb,'CyclicPrefix','Normal')); %#ok<SFLD>

if (isempty(eNodeBOutput))
    fprintf('\nReceived signal must not be empty.\n');
    return;
end

% Display received signal spectrum

spectrumAnalyzer(awgn(eNodeBOutput, 100.0));

if (sr~=ofdmInfo.SamplingRate)
    if (sr < ofdmInfo.SamplingRate)
        warning('The received signal sampling rate (%0.3fMs/s) is lower than the desired sampling rate for cell search / MIB decoding (%0.3fMs/s); cell search / MIB decoding may fail.',sr/1e6,ofdmInfo.SamplingRate/1e6);
    end
    fprintf('\nResampling from %0.3fMs/s to %0.3fMs/s for cell search / MIB decoding...\n',sr/1e6,ofdmInfo.SamplingRate/1e6);
else
    fprintf('\nResampling not required; received signal is at desired sampling rate for cell search / MIB decoding (%0.3fMs/s).\n',sr/1e6);
end
% Downsample received signal
nSamples = ceil(ofdmInfo.SamplingRate/round(sr)*size(eNodeBOutput,1));
nRxAnts = size(eNodeBOutput, 2);
downsampled = zeros(nSamples, nRxAnts);
for i=1:nRxAnts
    downsampled(:,i) = resample(eNodeBOutput(:,i), ofdmInfo.SamplingRate, round(sr));
end

%performing cell search
fprintf('\nPerforming cell search...\n');

% Set up duplex mode and cyclic prefix length combinations for search; if
% either of these parameters is configured in |enb| then the value is
% assumed to be correct
if (~isfield(enb,'DuplexMode'))
    duplexModes = {'TDD' 'FDD'};
else
    duplexModes = {enb.DuplexMode};
end
if (~isfield(enb,'CyclicPrefix'))
    cyclicPrefixes = {'Normal' 'Extended'};
else
    cyclicPrefixes = {enb.CyclicPrefix};
end

% Perform cell search across duplex mode and cyclic prefix length
% combinations and record the combination with the maximum correlation; if
% multiple cell search is configured, this example will decode the first
% (strongest) detected cell
searchalg.MaxCellCount = 1;
searchalg.SSSDetection = 'PostFFT';
peakMax = -Inf;
for duplexMode = duplexModes
    for cyclicPrefix = cyclicPrefixes
        enb.DuplexMode = duplexMode{1};
        enb.CyclicPrefix = cyclicPrefix{1};
        [enb.NCellID, offset, peak] = lteCellSearch(enb, downsampled, searchalg);
        enb.NCellID = enb.NCellID(1);
        offset = offset(1);
        peak = peak(1);
        if (peak>peakMax)
            enbMax = enb;
            offsetMax = offset;
            peakMax = peak;
        end
    end
end

% Use the cell identity, cyclic prefix length, duplex mode and timing
% offset which gave the maximum correlation during cell search
enb = enbMax;
offset = offsetMax;

% Compute the correlation for each of the three possible primary cell
% identities; the peak of the correlation for the cell identity established
% above is compared with the peak of the correlation for the other two
% primary cell identities in order to establish the quality of the
% correlation.
corr = cell(1,3);
idGroup = floor(enbMax.NCellID/3);
for i = 0:2
    enb.NCellID = idGroup*3 + mod(enbMax.NCellID + i,3);
    [~,corr{i+1}] = lteDLFrameOffset(enb, downsampled);
    corr{i+1} = sum(corr{i+1},2);
end
threshold = 1.3 * max([corr{2}; corr{3}]); % multiplier of 1.3 empirically obtained
if (max(corr{1})<threshold)
    warning('Synchronization signal correlation was weak; detected cell identity may be incorrect.');
end
% Return to originally detected cell identity
enb.NCellID = enbMax.NCellID;

% Plot PSS/SSS correlation and threshold
synchCorrPlot.YLimits = [0 max([corr{1}; threshold])*1.1];
synchCorrPlot([corr{1} threshold*ones(size(corr{1}))]);

% Perform timing synchronization
fprintf('Timing offset to frame start: %d samples\n',offset);
downsampled = downsampled(1+offset:end,:);
enb.NSubframe = 0;

% Show cell-wide settings
fprintf('Cell-wide settings after cell search:\n');
disp(enb);

%%->Performing frequency offset estimation...\n');

% For TDD, TDDConfig and SSC are defaulted to 0. These parameters are not
% established in the system until SIB1 is decoded, so at this stage the
% values of 0 make the most conservative assumption (fewest downlink
% subframes and shortest special subframe).
if (strcmpi(enb.DuplexMode,'TDD'))
    enb.TDDConfig = 0;
    enb.SSC = 0;
end
delta_f = lteFrequencyOffset(enb, downsampled);
fprintf('Frequency offset: %0.3fHz\n',delta_f);
downsampled = lteFrequencyCorrect(enb, downsampled, delta_f);

% Channel estimator configuration
cec.PilotAverage = 'UserDefined';     % Type of pilot averaging
cec.FreqWindow = 13;                  % Frequency window size
cec.TimeWindow = 9;                   % Time window size
cec.InterpType = 'cubic';             % 2D interpolation type
cec.InterpWindow = 'Centered';        % Interpolation window type
cec.InterpWinSize = 1;                % Interpolation window size

% Assume 4 cell-specific reference signals for initial decoding attempt;
% ensures channel estimates are available for all cell-specific reference
% signals
enb.CellRefP = 4;

fprintf('Performing OFDM demodulation...\n\n');

griddims = lteResourceGridSize(enb); % Resource grid dimensions
L = griddims(2);                     % Number of OFDM symbols in a subframe
% OFDM demodulate signal
rxgrid = lteOFDMDemodulate(enb, downsampled);
if (isempty(rxgrid))
    fprintf('After timing synchronization, signal is shorter than one subframe so no further demodulation will be performed.\n');
    return;
end
% Perform channel estimation
[hest, nest] = lteDLChannelEstimate(enb, cec, rxgrid(:,1:L,:));

%OFDM demodulation on full bandwidth
fprintf('Restarting reception now that bandwidth (NDLRB=%d) is known...\n',enb.NDLRB);

% Resample now we know the true bandwidth
ofdmInfo = lteOFDMInfo(enb);
if (sr~=ofdmInfo.SamplingRate)
    if (sr < ofdmInfo.SamplingRate)
        warning('The received signal sampling rate (%0.3fMs/s) is lower than the desired sampling rate for NDLRB=%d (%0.3fMs/s); PDCCH search / SIB1 decoding may fail.',sr/1e6,enb.NDLRB,ofdmInfo.SamplingRate/1e6);
    end
    fprintf('\nResampling from %0.3fMs/s to %0.3fMs/s...\n',sr/1e6,ofdmInfo.SamplingRate/1e6);
else
    fprintf('\nResampling not required; received signal is at desired sampling rate for NDLRB=%d (%0.3fMs/s).\n',enb.NDLRB,sr/1e6);
end
nSamples = ceil(ofdmInfo.SamplingRate/round(sr)*size(eNodeBOutput,1));
resampled = zeros(nSamples, nRxAnts);
for i = 1:nRxAnts
    resampled(:,i) = resample(eNodeBOutput(:,i), ofdmInfo.SamplingRate, round(sr));
end

% Perform frequency offset estimation and correction
fprintf('\nPerforming frequency offset estimation...\n');
delta_f = lteFrequencyOffset(enb, resampled);
fprintf('Frequency offset: %0.3fHz\n',delta_f);
resampled = lteFrequencyCorrect(enb, resampled, delta_f);

% Find beginning of frame
fprintf('\nPerforming timing offset estimation...\n');
offset = lteDLFrameOffset(enb, resampled);
fprintf('Timing offset to frame start: %d samples\n',offset);
% Aligning signal with the start of the frame
resampled = resampled(1+offset:end,:);

% OFDM demodulation
fprintf('\nPerforming OFDM demodulation...\n\n');
rxgrid = lteOFDMDemodulate(enb, resampled);

%steps to decode LTE cell id and stuff like that
% Check this frame contains SIB1, if not advance by 1 frame provided we
% have enough data, terminate otherwise.
if (mod(enb.NFrame,2)~=0)
    if (size(rxgrid,2)>=(L*10))
        rxgrid(:,1:(L*10),:) = [];
        fprintf('Skipping frame %d (odd frame number does not contain SIB1).\n\n',enb.NFrame);
    else
        rxgrid = [];
    end
    enb.NFrame = enb.NFrame + 1;
end

% Advance to subframe 5, or terminate if we have less than 5 subframes
if (size(rxgrid,2)>=(L*5))
    rxgrid(:,1:(L*5),:) = [];   % Remove subframes 0 to 4
else
    rxgrid = [];
end
enb.NSubframe = 5;

if (isempty(rxgrid))
    fprintf('Received signal does not contain a subframe carrying SIB1.\n\n');
end

% Reset the HARQ buffers
decState = [];

% While we have more data left, attempt to decode SIB1
while (size(rxgrid,2) > 0)

    fprintf('%s\n',separator);
    fprintf('SIB1 decoding for frame %d\n',mod(enb.NFrame,1024));
    fprintf('%s\n\n',separator);

    % Reset the HARQ buffer with each new set of 8 frames as the SIB1
    % info may be different
    if (mod(enb.NFrame,8)==0)
        fprintf('Resetting HARQ buffers.\n\n');
        decState = [];
    end

    % Extract current subframe
    rxsubframe = rxgrid(:,1:L,:);

    % Perform channel estimation
    [hest,nest] = lteDLChannelEstimate(enb, cec, rxsubframe);

    % PCFICH demodulation, CFI decoding. The CFI is now demodulated and
    % decoded using similar resource extraction and decode functions to
    % those shown already for BCH reception. lteExtractResources is used to
    % extract REs corresponding to the PCFICH from the received subframe
    % rxsubframe and channel estimate hest.
    fprintf('Decoding CFI...\n\n');
    pcfichIndices = ltePCFICHIndices(enb);  % Get PCFICH indices
    [pcfichRx, pcfichHest] = lteExtractResources(pcfichIndices, rxsubframe, hest);
    % Decode PCFICH
    cfiBits = ltePCFICHDecode(enb, pcfichRx, pcfichHest, nest);
    cfi = lteCFIDecode(cfiBits); % Get CFI
    if (isfield(enb,'CFI') && cfi~=enb.CFI)
        release(pdcchConstDiagram);
    end
    enb.CFI = cfi;
    fprintf('Decoded CFI value: %d\n\n', enb.CFI);

    % For TDD, the PDCCH must be decoded blindly across possible values of
    % the PHICH configuration factor m_i (0,1,2) in TS36.211 Table 6.9-1.
    % Values of m_i = 0, 1 and 2 can be achieved by configuring TDD
    % uplink-downlink configurations 1, 6 and 0 respectively.
    if (strcmpi(enb.DuplexMode,'TDD'))
        tddConfigs = [1 6 0];
    else
        tddConfigs = 0; % not used for FDD, only used to control while loop
    end
    alldci = {};
    while (isempty(alldci) && ~isempty(tddConfigs))
        % Configure TDD uplink-downlink configuration
        if (strcmpi(enb.DuplexMode,'TDD'))
            enb.TDDConfig = tddConfigs(1);
        end
        tddConfigs(1) = [];
        % PDCCH demodulation. The PDCCH is now demodulated and decoded
        % using similar resource extraction and decode functions to those
        % shown already for BCH and CFI reception
        pdcchIndices = ltePDCCHIndices(enb); % Get PDCCH indices
        [pdcchRx, pdcchHest] = lteExtractResources(pdcchIndices, rxsubframe, hest);
        % Decode PDCCH and plot constellation
        [dciBits, pdcchSymbols] = ltePDCCHDecode(enb, pdcchRx, pdcchHest, nest);
        pdcchConstDiagram(pdcchSymbols);

        % PDCCH blind search for System Information (SI) and DCI decoding.
        % The LTE Toolbox provides full blind search of the PDCCH to find
        % any DCI messages with a specified RNTI, in this case the SI-RNTI.
        fprintf('PDCCH search for SI-RNTI...\n\n');
        pdcch = struct('RNTI', 65535);
        pdcch.ControlChannelType = 'PDCCH';
        pdcch.EnableCarrierIndication = 'Off';
        pdcch.SearchSpace = 'Common';
        pdcch.EnableMultipleCSIRequest = 'Off';
        pdcch.EnableSRSRequest = 'Off';
        pdcch.NTxAnts = 1;
        alldci = ltePDCCHSearch(enb, pdcch, dciBits); % Search PDCCH for DCI
    end

    % If DCI was decoded, proceed with decoding PDSCH / DL-SCH
    for i = 1:numel(alldci)

        dci = alldci{i};
        fprintf('DCI message with SI-RNTI:\n');
        disp(dci);
        % Get the PDSCH configuration from the DCI
        [pdsch, trblklen] = hPDSCHConfiguration(enb, dci, pdcch.RNTI);

        % If a PDSCH configuration was created, proceed with decoding PDSCH
        % / DL-SCH
        if ~isempty(pdsch)

            pdsch.NTurboDecIts = 5;
            fprintf('PDSCH settings after DCI decoding:\n');
            disp(pdsch);

            % PDSCH demodulation and DL-SCH decoding to recover SIB bits.
            % The DCI message is now parsed to give the configuration of
            % the corresponding PDSCH carrying SIB1, the PDSCH is
            % demodulated and finally the received bits are DL-SCH decoded
            % to yield the SIB1 bits.

            fprintf('Decoding SIB1...\n\n');
            % Get PDSCH indices
            [pdschIndices,pdschIndicesInfo] = ltePDSCHIndices(enb, pdsch, pdsch.PRBSet);
            [pdschRx, pdschHest] = lteExtractResources(pdschIndices, rxsubframe, hest);
            % Decode PDSCH
            [dlschBits,pdschSymbols] = ltePDSCHDecode(enb, pdsch, pdschRx, pdschHest, nest);
            % Decode DL-SCH with soft buffer input/output for HARQ combining
            if ~isempty(decState)
                fprintf('Recombining with previous transmission.\n\n');
            end
            [sib1, crc, decState] = lteDLSCHDecode(enb, pdsch, trblklen, dlschBits, decState);

            % Compute PDSCH EVM
            recoded = lteDLSCH(enb, pdsch, pdschIndicesInfo.G, sib1);
            remod = ltePDSCH(enb, pdsch, recoded);
            [~,refSymbols] = ltePDSCHDecode(enb, pdsch, remod);
            [rmsevm,peakevm] = pdschEVM(refSymbols{1}, pdschSymbols{1});
            fprintf('PDSCH RMS EVM: %0.3f%%\n',rmsevm);
            fprintf('PDSCH Peak EVM: %0.3f%%\n\n',peakevm);

            fprintf('SIB1 CRC: %d\n',crc);
            if crc == 0
                fprintf('Successful SIB1 recovery.\n\n');
            else
                fprintf('SIB1 decoding failed.\n\n');
            end

        else
            % Indicate that creating a PDSCH configuration from the DCI
            % message failed
            fprintf('Creating PDSCH configuration from DCI message failed.\n\n');
        end

    end
    if (numel(alldci)==0)
        % Indicate that DCI decoding failed
        fprintf('DCI decoding failed.\n\n');
    end

    % Update channel estimate plot
    figure(channelFigure);
    surf(abs(hest(:,:,1,1)));
    hSIB1RecoveryExamplePlots(channelFigure);
    channelFigure.CurrentAxes.XLim = [0 size(hest,2)+1];
    channelFigure.CurrentAxes.YLim = [0 size(hest,1)+1];

    % Skip 2 frames and try SIB1 decoding again, or terminate if we
    % have less than 2 frames left.
    if (size(rxgrid,2)>=(L*20))
        rxgrid(:,1:(L*20),:) = [];   % Remove 2 more frames
    else
        rxgrid = []; % Less than 2 frames left
    end
    enb.NFrame = mod(enb.NFrame + 2,1024);

end


