% 2019-6-17 YXC

map = obj_90626A00_G;

center = 14;
away = 1;
compareleft = map.map(:,:,center)./map.map(:,:,center-away);
compareright = map.map(:,:,center)./map.map(:,:,center+away);
peak = compareleft.*compareright>2;

map.map(:,:,1) = peak;
map.name = 'zeropeakmap_90626a00';
img_obj_viewer_test(map);
