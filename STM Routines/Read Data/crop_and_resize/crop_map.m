function map=crop_map(map,lmax)
% insert walues in code
[sy,sx,sz]=size(map);
lmin=1;
delt=lmax-lmin+1;
map2=zeros(delt,delt,sz);
for i=1:sz
    map2(:,:,i)=map(lmin:lmax,lmin:lmax,i);
end
map=map2;