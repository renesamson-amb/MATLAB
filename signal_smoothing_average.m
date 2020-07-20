%program for signal smoothing
%by averagin
clf;
R = 51;
d = 0.8 *(rand(R,1) - 0.5); %Generate random notes 
m = 0:R-1;
s = 2*m.*(0.9.^m); %Generate uncorrupted signal
x = s + d';        %Generate noise corrupted signal
%the ' in the above line is a complex conjugate function
figure (1);
plot(m,d' , 'r-', m,s, 'g--', m,x,'b-.');
xlabel('time index n'); ylabel('Amplitude');
legend('d[n]', 's[n]','x[n]');
x1 = [0 0 x]; x2 = [0 x 0]; x3= [x 0 0];
y = (x1+x2+x3)/3;
figure (2);
plot(m,y(2:R+1),'r-',m,s,'g--');
legend('y[n]' , 's[n]');
xlabel('Time index n');ylabel('Amplitude');

