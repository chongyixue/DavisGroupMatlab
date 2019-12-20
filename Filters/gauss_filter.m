%%%%%%%
% CODE DESCRIPTION: The map is gaussian blurred and then subtracted from
% the original image.  The new image thus has long wavelength features
% removed from it as a result of the subtraction.  
%   
% INPUT: The function accepts a data structure containing the map (data.map) as well
% as the pixel size and standard deviation of the gaussian used.
%
% CODE HISTORY
% 0804018 MHH Created

function new_data = gauss_filter(data,pixel,std)

h = fspecial('gaussian',std,pixel);
blur_map = imfilter(data.map,h,'replicate');
new_map = blur_map;

new_map = data.map - blur_map;
new_data = data;
new_data.map = new_map;

end