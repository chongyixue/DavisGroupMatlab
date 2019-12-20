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

function new_data = LoG_filter_image(data,pixel,std)


if isstruct(data) % check if data is a full data structure
  %  [nr,nc,nz]=size(data.map);
    tmp_data = data.map;
else % single data image
 %   [nr,nc,nz] = size(data);
    tmp_data = data;
end
% h = fspecial('gaussian',std,pixel);
%% Changed by Peter Sprau 05/22/14, definition for fspecial is h = fspecial('gaussian', hsize, sigma), so the 
%% way it was defined before didn't make sense
h = fspecial('log',pixel,std);
blur_map = imfilter(tmp_data,h,'replicate');
% you don't need to subtract because the derivative eliminates the constant
% part of the map, filters out the low frequency content
new_map = blur_map;




if isstruct(data) % check if data is a full data structure
    new_data = data;
    new_data.map = new_map;   
else % single data image
    new_data = new_map;
end


%new_data = data;
%new_data.map = new_map;

end