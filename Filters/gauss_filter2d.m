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

function new_data = gauss_filter2d(data,pixel,std)
h = fspecial('gaussian',std,pixel);
if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    tmp_data = data.map;
    blur_map = imfilter(tmp_data,h,'replicate');
    new_map =  tmp_data - blur_map;
    new_data = data;
    new_data.map = new_map;
else % single data image
    [nr,nc,nz] = size(data);
    tmp_data = data;
    blur_map = imfilter(tmp_data,h,'replicate');   
    new_data =  tmp_data - blur_map;

end
end