function [uc,map4d]=average_cell(map,cy,cx,abst)
%abst is half

[sy,sx,sz]=size(map);
uc=zeros(2*abst+1,2*abst+1,sz);
map4d=nan(2*abst+1,2*abst+1,sz,length(cx));


for j=1:sz
    j
    for k=1:length(cy)
        gety=cy(k)-abst:cy(k)+abst;
        getx=cx(k)-abst:cx(k)+abst;
        [gety,getx]=ndgrid(gety,getx);
        littlePlane=map(:,:,j);
        littlePlane=interp2(littlePlane,getx,gety);
        map4d(:,:,j,k)=littlePlane;
        uc(:,:,j)=uc(:,:,j)+littlePlane;
     end
end

uc=uc/length(cy);
