%delayed unit step program 
clf;            %delay the 
n = -9 : 200;   %vector size
delay = 7;      %delay       
u = [zeros(1,(10+delay)) ones(1,(200-delay))]; %values of the vector
plot(n,u); %plot the shape
xlabel('time index n'); ylabel('Amplitude');
title('delayed unit response');
