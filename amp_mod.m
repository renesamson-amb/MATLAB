
clf;
n=0:100;
m= 0.4;fH= 0.1;fL=0.01;
xH = sin(2*pi*fH*n);
xL = sin(2*pi*fL*n);
y = (1+ m*xL).*xH;
stem(n,y);grid;
xlabel('Time index n');ylabel('Amplitude');