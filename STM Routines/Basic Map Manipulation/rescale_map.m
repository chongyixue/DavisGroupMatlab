%%%%%%%
% CODE DESCRIPTION: Rescaling of data maps by downsampling 
%                       
% INPUT: The function accepts the data matrix and two scalar values
% corresponding to new the size of the data matrix
%
% CODE HISTORY
% 080721 MHH Created

function new_data = rescale_map(data,x_pixel,y_pixel)
[dx dy] = size(data);

s_x = dx/x_pixel;
s_y = dy/y_pixel;
if (s_x < 1 || s_y < 1)
    'Cannot downsample with given values'
    return;
end
new_data = zeros(y_pixel,x_pixel);
new_data(:,:) = data(1:round(s_y):end,1:round(s_x):end);
end
