function conv = simple_conv(f,g)
%transform the vectors f and g in new vectors
%with same length
    F = [f,zeros(1,length(g))];
    G = [g,zeros[1,length(f))];
    
    for i = 1:length(g) + length(f)-1
        c(i) = 0;
        for j=1:length(f)
            if(i-j+1>0)
                c(i) = c(i)+F(j) *G(i-j+1);
            end
        end
    end
    out = c;
end

%convolution can be used for filtering
%by choosing a proper impulse response 


    