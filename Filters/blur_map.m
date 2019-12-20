function new_data = blur_map(data,pixel,std)

h = fspecial('gaussian',std,pixel);
blur_map = imfilter(data.map,h,'replicate');
new_data = data;
new_data.map = blur_map;

end