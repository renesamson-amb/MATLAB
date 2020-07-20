%random example
L = 100;
prob1 = 0.5; prob2 = 0.6; prob3 = 0.2;
b1 = round(0.5*rand(1,L)+0.5*prob1);%even split between 1 and 0 values
b2 = round(0.5*rand(1,L)+0.5*prob2);
b3 = round(0.5*rand(1,L)+0.5*prob3);

figure(1);
stem(b1);
figure(2);
stem(b2);
figure(3);
stem(b3);

