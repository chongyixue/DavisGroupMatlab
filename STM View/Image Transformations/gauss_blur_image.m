function new_data = gauss_blur_image(data,pixel,std)

h = fspecial('gaussian',pixel,std);
if isstruct(data)
    blur_map = imfilter(data.map,h,'replicate');
    new_data = data;
    new_data.map = blur_map;
else
    blur_map = imfilter(data,h,'replicate');
    new_data = blur_map;
end

end