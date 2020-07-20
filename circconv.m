%DFT properties
% functions used as commands used circshift and circonv

% please note this is how functions are written in 
% matlab
%program for circular shift
 clf;
 M = -6;
 a = [0 1 2 3 4 5 6 7 8 9];
 b = circshift(a,M);
 L = length(a) - 1;
 n = 0:L;
 % plotting 
 figure(1);
 stem(n,a); axis([0,L,min(a),max(a)]);
 title('Original sequence');
 % plotting
 figure(2);
 stem(n,b);axis([0,L,min(a),max(a)]);
 title('Sequence obtained by circular shifting a by \(num2str(M)) samples');
 
 %program for circular time shifting property of DFT(or FFT)
 x = [0 2 4 6 8 10 12 14 16];
 N = length(x)-1; n=0:N;
 y = circshift(x,5); %new sequence that is a shifted version of x
 res = circonv(x,y);
 %to prove
 %multiplication in frequency domain is convolution in frequency domain
 XF = fft(x);
 XY = fft(y);
 XRES1 = XF.*XY; %multiplication of frequency components
 XRES2 = fft(res); %FFT of convoluted sequence
 figure(3);
 stem(n,abs(XF));
 title('mag of x');
 figure(4);
 stem(n,angle(XF));
 title('phase of x');
 figure (5);
 stem(n,abs(XY));
 title('mag of Y');
 figure(6);
 stem(n,angle(XY));
 title('phase of y');
 
 figure(7);
 stem(n,XRES1);
 title('multiplication of frequency components');
 figure(8);
 stem(n,XRES2);
 title('FFT of convoluted signal');
 
 
function y = circshift(x,M)
    %develops a new sequence"y" by 
    %circularly shifting the sequence "x" by 
    %M samples
    
if abs(M) > length(x)
    M = rem(M,length(x));
end
if M < 0
    M = M + length(x);
end
y = [x(M+1:length(x)) x(1:M)];
end


function y = circonv(x1,x2)
    %function for circular convolution of 
    %two signals x1 and x2
    L1= length(x1); L2= length(x2);
    if L1 ~= L2
        error('Sequence of unequal lengths');
    end
    y = zeros(1,L1);
    x2tr = [x2(1) x2(L2:-1:2)];
    for k = 1:L1
        sh = circshift(x2tr, 1-k);
        h = x1.*sh;
        y(k) = sum(h);
    end
end

   

    
    
    
    
    
