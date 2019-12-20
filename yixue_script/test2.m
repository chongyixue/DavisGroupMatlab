%find the two coherence peak in a spectrum



firsttest = maximapositions(x,y,1);
morethantwo=length(firsttest);

i=1;
for i=1 : morethantwo
    secondtestvalue(i) = peakgradient(x,y,firsttest(i),2);
    secondtest (i) = firsttest(i);
    %can change the last number above for larger range gradient
end


[whatever,index1]=max(secondtestvalue)
position(1) = secondtest(index1)
secondtestvalue(index1)=0
[whatever2,index2]=max(secondtestvalue)
position(2) = secondtest(index2)

