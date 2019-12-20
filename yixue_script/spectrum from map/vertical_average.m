function map2 = vertical_average(map1,n_y)

% map1 = obj_81008a00_G_rescale;
map2 = map1;
pixels = size(map1.map,1);
layers = size(map1.map,3);

% n_y = 7; %number of pixels to average in y direction

for layer = 1:layers
    for x = 1:pixels
        value = 0;
        for y = 1:n_y
            value = value + map1.map(y,x,layer);
        end
        value = value/n_y;
        map2.map(:,x,layer) = value;
    end
end
map2.name = [map2.name '_y-averaged'];
img_obj_viewer_test(map2)

end