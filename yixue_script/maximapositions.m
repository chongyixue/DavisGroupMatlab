% find maxima then return 'peak coordinate'

function position = maximapositions(x,y,n)

n=1;
k=1;
i=n+1;
position = 0;

for i = n+1 : length(x)-(n+1)
        gradient = peakgradient(x,y,i,n);
        if gradient > 0
        position(k) = i;
        k=k+1;
        i=i+1;
        end
        
end


end
       