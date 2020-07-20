%Define simulation parameers
L  = 10000000;%length of data streams
res_hist = 100; %histogram resolution
std_dev = 5; %standard deviation of input gaussian variables

%create uncorrelated 2D gaussian random variables
x_normal_1 = std_dev .*randn(1,L);
y_normal_1 = std_dev .*randn(1,L);

%create cross correlated 2D gaussian random data streams
x_normal_2 = x_normal_1 +0.1*y_normal_1;
y_normal_2 = y_normal_1 +0.9*x_normal_1;

%Z = x_normal_1.*(y_normal_1)';
figure(1);
plot(x_normal_1);
title('uncorrelated 2D gaussian RVs');
figure(2);
plot(y_normal_1);
%contour3(Z);
%hold off; 
%second figure
figure(3);
plot(x_normal_2);
title('Correlated 2D gaussian RVs');
figure(4);
plot(y_normal_2);
%hold off;