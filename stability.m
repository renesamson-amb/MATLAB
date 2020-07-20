%stability of a system based on absolute summability of 
%a systems

clf;
num = [1 -0.8];den = [1 1.5 0.9];
N = 200;
h = impz(num,den,N+1);
parsum = 0;
for k = 1:N+1
    parsum = parsum + abs(h(k));
    if(abs(h(k))) < 10^(-6), break, end
end
%plot the impulse response
%n=0:N;
stem(h);
xlabel('Time index n');ylabel('Amplitude');
disp('value ='); disp(parsum);

%   second problem
%   to compute the impulse response and hence stability of the belo
%   system
%   y[n] -1.7y[n-1]+y[n-2] = x[n]-4x[n-1]+3x[n+2]

num1 = [1 -4 3];
den1 = [1 -1.7 1];
%use N value from above section
h1 = impz(num1,den1,N+1);
sum = 0;
for k= 1:N+1
    sum = sum + abs(h(k));
    if(abs(h(k))) < 10^(-6) 
        break 
    end
end
%plot the impulse response
figure(2);
stem(h1);
ylabel('Amplitude');xlabel('time index n');
title('impulse and stability of second system');
grid;
disp('Value of second system =');disp(sum);