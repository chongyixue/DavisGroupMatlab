function new_data = blur(data,pixel,std)

h = fspecial('gaussian',std,pixel);
new_data = imfilter(data,h,'replicate');


end