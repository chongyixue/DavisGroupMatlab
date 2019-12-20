%insert gap magnitude into point
%input example gap(obj_70228A00_G,obj_70228A00_T)
%24 May 2017

function [gapmap]= gapgap(map,topo)


gapmap = topo;
p=1;
q=1;
L=length(topo.topo1);

for q=1 : L
    
    for p=1 : L
    [x,y] = spectrumdata(map,q,p);
    gapmap.map(p,q) = gapmagnitude(x,y);
    p=p+1;
    end 
    
    q=q+1;
end
end