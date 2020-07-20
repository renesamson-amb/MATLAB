%program to generate a unit step sequence s[n] 
clf;
n = -10:200;
u= [zeros(1,11) ones(1,200)];
plot (n,u);
xlabel('time index n'); ylabel('Amplitude');
title('Unit Step Sequence');
axis ([-10 200 0 1.2]);

