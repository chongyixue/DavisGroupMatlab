%%%%%%%
% CODE DESCRIPTION: Averaging filter.
%   
% INPUT: The function accepts a data structure containing the map (data.map) as well
% as the pixel size and standard deviation of the gaussian used.
%
% CODE HISTORY
% 06/24/14 Peter Sprau Created

function new_data = ave_filter_image(data,pixelx,pixely)


if isstruct(data) % check if data is a full data structure
  %  [nr,nc,nz]=size(data.map);
    tmp_data = data.map;
else % single data image
 %   [nr,nc,nz] = size(data);
    tmp_data = data;
end


h = fspecial('average',[pixelx,pixely]);
blur_map = imfilter(tmp_data,h,'replicate');


if isstruct(data) % check if data is a full data structure
    new_data = data;
    new_data.map = blur_map;   
else % single data image
    new_data = blur_map;
end



end