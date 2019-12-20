%find max and check grdient

function yy = peakgradient(x,y,indexx,n)

yy=0;

%sometimes data comes in a way the x goes from -ve to positive
if x(indexx+n)-x(indexx)<0
    i=1;
    for i=1:length(x)
        xxx(i)=x(length(x)+1-i);
        yyy(i)=y(length(x)+1-i);
        i=i+1;
    end
    x=xxx;
    y=yyy;
end
    

if indexx-n>0 
    leftg=(y(indexx)-y(indexx-n))/(x(indexx)-x(indexx-n));
    rightg=(y(indexx+n)-y(indexx))/(x(indexx+n)-x(indexx));
    if sign(leftg)<0
        leftg=0;
    end
    if sign(rightg)>0
        rightg=0;
    end
    pseudogradient =-(leftg*rightg);
    yy=pseudogradient;
end

end

%[maxx,indexx]  = max(y);
%n=3;
%pseudogradient =(y(indexx)-y(indexx-n))/(x(indexx)-x(indexx-n))+(y(indexx)-y(indexx+n))/(x(indexx+n)-x(indexx))

