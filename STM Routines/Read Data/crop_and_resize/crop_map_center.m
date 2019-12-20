function map=crop_map_center(map,siz)
% like crop_map, but takes the center section
[sy,sx,sz]=size(map);
bx=ceil((sx-siz)/2);
by=ceil((sy-siz)/2);

map2=zeros(sy-2*by,sx-2*bx,sz);
for k=1:sz
    map2(:,:,k)=map(by+1:sy-by,bx+1:sx-bx,k);
end

map=map2;
