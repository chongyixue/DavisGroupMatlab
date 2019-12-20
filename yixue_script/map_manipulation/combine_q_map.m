% 2018-9-17
% combine q space map, (after roughly adjusting pixel and putting Bragg
% peaks at same location

map1 = obj_81016a00_G;
map2 = obj_81017A00_G;
newmap = map1;

n_layer1 = length(map1.e);
n_layer2 = length(map2.e);
n_total = n_layer1+n_layer2;

layer1 = 1;
layer2 = 1;
skip1 = 0;
skip2 = 0;

for layer = 1:n_total
    
    if layer1>n_layer1
        layer1 = n_layer1;
        skip1 = 1;
    end
    if layer2>n_layer2
        layer2 = n_layer2;
        skip2 = 1;
    end
    
    if skip1 == 1
        e1 = map2.e(n_layer2)+10;
    else
        e1 = map1.e(layer1);
    end
    
    if skip2 == 1
        e2 = map1.e(n_layer1)+10;
    else
        e2 = map2.e(layer2);
    end
    
    %check who is more negative
    
    if e2<e1 
        newmap.e(layer) = e2;
        newmap.map(:,:,layer)=map2.map(:,:,layer2);
        layer2 = layer2 + 1;
        
    else
        newmap.e(layer) = e1;
        newmap.map(:,:,layer)=map1.map(:,:,layer1);
        layer1 = layer1 + 1;
    end
end

        
newmap.var = 'combine';
img_obj_viewer_yxc(newmap);
