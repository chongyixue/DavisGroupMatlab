% 2019-6-7 YXC
% fit LL peter-style fitting


map = obj_90228A00_G;
map = invert_map(map);

map = smallmap;

[mapcell, svec, evec] = cutupdata(map, 1);

llfpar_90228a00 = zeros(3,6,1);
llfpar_90228a00(1,:,1) = [21,38,54,62,69,74]; %LLpoints
llfpar_90228a00(2,:,1) = [2,3,2,2,2,1]; %halfwidth half maximum
llfpar_90228a00(3,:,1) = [3,7,5,3,3,2]; %pixels to left and right for fitting

[llmap, llwmap, llamap, llarea, cbkg, lbkg, qbkg, qbkgc] = CBST_LL_fitting_revisited2016(map, mapcell, llfpar_90228a00, svec, evec);


map.map(:,:,1) = llmap(:,:,1);
map.map(:,:,2) = llmap(:,:,2);
map.map(:,:,3) = llmap(:,:,3);
map.map(:,:,4) = llmap(:,:,4);
map.map(:,:,5) = llmap(:,:,5);
map.map(:,:,6) = llmap(:,:,6);

img_obj_viewer_test(map);