%find gap magnitude (difference in x)

function gap = gapmagnitude(x,y)

index=peakfinderyxc(x,y);
if or(index(1)==0,index(2)==0)
    gap = 0;
else
    gap = x(index(2))-x(index(1));
    gap = gap*sign(gap)/2;
end
end