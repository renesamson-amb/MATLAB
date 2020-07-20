% program for generation and ploting a "delayed" unit sample sequence
% same coordinates as P1_1.m program
clf;
n = -10:20;
delay = 11;
%generate the unit sample sequence
u = [zeros(1,(delay+10)) 1 zeros(1,9)];
%plot the sequences
stem (n,u);
%stem command runs with vector and values of vector
xlabel('Time index n'); ylabel('Amplitude');
axis([-10 20 0 1.2]);
%the first two value is for x range
%the next two values if for y range
