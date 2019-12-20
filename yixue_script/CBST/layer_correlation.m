% 2019-10-1 YXC

map = obj_50211A00_G;

map2 = map;
[~,~,nz] = size(map.map);

for i = 1:nz-1
    map2.map(:,:,i) = norm_xcorr2d(map.map(:,:,i),map.map(:,:,i+1));
    map2.e(i)=(map.e(i)+map.e(i+1))/2;
end

map2.name = 'correlationlayers';
img_obj_viewer_test(map2)






