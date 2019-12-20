map=obj_70912A00_G;
topo=obj_70912A00_T;

gapmap = topo;
p=1;
q=1;
L=length(topo.topo1);

[x,y] = spectrumdata(map,2,4);
gapmap.map(1,1) = gapmagnitude(x,y);

