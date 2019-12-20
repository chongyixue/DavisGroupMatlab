% check background subtraction order 0 is just every pixel subtracted by
% the average

sum = 0;
pixels = size(map.map,2);

for x = 1:pixels
    for y = 1:pixels
        sum = sum + map.map(y,x,1);
    end
end
sum = sum/(pixels*pixels);

newmap = map;
newmap.name = 'sanity_check';
for x = 1:pixels
    for y = 1:pixels
        newmap.map(y,x,1)=map.map(y,x,1)-sum;
    end
end
img_obj_viewer_test(newmap);