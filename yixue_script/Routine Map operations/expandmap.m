% 2021-6-28

function newmap = expandmap(map,n)
newmap = map;
newmap.e = [];
[nx,ny,nE] = size(map.map);
newmap.map = zeros(nx,ny,nE*n);
for i=1:n
   newmap.e = [newmap.e,map.e]; 
   newmap.map(:,:,(i-1)*nE + 1:i*nE)=map.map;
end
% img_obj_viewer_test(expandmap);
end