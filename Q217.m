% another system 
%y[n] = x[n]*n + x[n-1];
clf;
n=0:40;
x = cos(2*pi*0.1*n);
x1= [zeros(1,1) x];
%nx[n] signal computation
m=n.*x;
%figure m => first figure;
figure(1);
stem(n+2,x);grid;
title('nx[n]');
xlabel('time index n');ylabel('Amplitude');
%figure xl => second figure
figure(2);
stem((n+2),x1(1:41));grid;
title('x[n-1]');
xlabel('time index n');ylabel('Amplitude');
%figure combined :p

