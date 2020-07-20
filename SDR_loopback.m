%template1
%perform data collection then offline processing
frameSize = 10e5;framesToCollect = 50;
rx = comm.SDRuReceiver('Platform','B200', ...
    'SerialNum','30FD65A', ...
    'DecimationFactor',256, ...
    'SamplesPerFrame',2^15);
  
tx = comm.SDRuTransmitter('Platform','B200', ...
    'SerialNum','30FD65A');

sine = dsp.SineWave('Frequency', 300, ...
    'SampleRate', 600, ...
    'SamplesPerFrame', 2^12, ...
    'ComplexOutput', true);
transmitRepeat(tx,sine()); %transmit continously
%setup scope
samplesPerStep = rx.SamplesPerFrame/600;
steps = 3;
ts = dsp.TimeScope('SampleRate', 600, ...
    'TimeSpan', samplesPerStep * steps, ...
    'BufferLength', rx.SamplesPerFrame*steps);
%receivee and view sine
for k= 1:steps
    ts(rx());
end




