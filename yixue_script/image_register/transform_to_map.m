% 2018-11-14
% apply the tform obtained from topo_register.m to transform map

map0 = obj_81108a00_G;
map8 = obj_81109a00_G;

layers = size(map0.map,3);

for n = 1:layers
    map0.map(:,:,n) =  imwarp(map0.map(:,:,n),tform,'OutputView',imref2d(size(upright)));
end
img_obj_viewer_test(map0)

% then crop both maps from (20,1) to (175,156)