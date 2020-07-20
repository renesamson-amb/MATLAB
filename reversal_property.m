%program files
%time reversal property of DTFT
clf;
w = -pi:2*pi/255:pi;
num = [1 2 3 4];
L  = length(num) -1; %3 in this case
h1 = freqz(num, 1 ,w);
h2 = freqz(fliplr(num),1,w); 
%note new command fliplr => flips along a vertical axis
% h2 is the negative convolved frequency spectrum
% i.e we have h*[-n]
%   we want h[-n]: so further DTFT is performed to get 
%   h[-n] : this is multiplying by e^(jwn);
%   below step illustrates that
h3 = exp(w*L*i).*h2; %
%with e^(jw3)

%
figure(1);
plot(w/pi, abs(h1));grid;
title('Magnitude spectrum of Original sequence');
%
figure(2);
plot(w/pi, abs(h3));grid;
title('Magnitude spectrum of flipped sequence');
%
figure(3);
plot(w/pi,angle(h1));grid;
title('phase spectrum of Original sequence');
%
figure(4);
plot(w/pi,angle(h3));grid;
title('phase spectrum of flipped sequence');
