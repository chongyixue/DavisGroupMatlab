% 2019-2-5 YXC

map = map2;

%100 to 250mV
startlayer = 61;
endlayer = 91;

for layer = startlayer:62
    tempmap = map;
    clear tempmap.map;
    clear tempmap.e;
    tempmap.map = map.map(:,:,layer);
    tempmap.e = map.e(layer);
    img_obj_viewer_yxc(tempmap);
end