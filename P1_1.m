% program for generation and ploting a unit sample sequence
clf;
%above command is used commonly to clear function
%generate a vector from -10 to 20
n = -10:20;
%generate the unit sample sequence
u = [zeros(1,10) 1 zeros(1,20)];
%plot the sequences
stem (n,u);
%stem command runs with vector and values of vector
xlabel('Time index n'); ylabel('Amplitude');
axis([-10 20 0 1.2]);
%the first two value is for x range
%the next two values if for y range
