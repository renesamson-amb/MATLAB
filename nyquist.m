Fs = 2300; 
Fa = 1105;
%determine nyquist zones
zone = 1 + floor ( Fa / (Fs/2));
alias = mod(Fa, Fs);
if ~mod(zone,2) 
    %this will generate a 1 only when the sample frequency
    %is atleast twice or greater than max frequency
    %basically gives the nyquist zone (0 - fs/2) in which the
    %max frequency is in.
    alias = -(Fs - alias)/Fs;
else
    alias = (alias)/Fs;
end
%create the analog/time domain  and digital sampling vectors
N = 2*1/abs(alias) + 1; % Number of Digital Samples
points = 256;           %Analog points between digital samples
analogIndexes = 0:1/points:N-1;
samplingIndexes = 1:points:length(analogIndexes);
wave = sin(2*pi*Fa/Fs * analogIndexes);
plot(wave);


