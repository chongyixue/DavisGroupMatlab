%%%%%%%
% CODE DESCRIPTION: Shear a map based on the shear factors sx and sy.
% Shearing produces regions of no data which are set to nan instead of 0
% (as done by default by imtransform).
%   
% CODE HISTORY
%
% 090818 MHH Created
%
%%%%%%%
function new_data = shear_map(data,sx,sy)
[nr nc nz] = size(data.map);

new_data = data;

% Since shearing will produce regions that were not in the map before, one
% must set those values to nan so that they don't affect further
% manipulatins of the map.  This can be done by applying the shear to a nan
% template to identify the areas introduced into the map by the shearing
% transformation.
nan_tmp = nan(nr,nc, nz);

tform = maketform('affine',[1 sy 0; sx 1 0; 0 0 1]);
new_data.map = imtransform(data.map, tform,'bicubic',... 
                        'UData',[data.r(1) data.r(end)],...
                        'VData', [data.r(1) data.r(end)],...
                        'XData',[data.r(1) data.r(end)],...
                        'YData', [data.r(1) data.r(end)],...
                        'size', size(data.map));          

nan_tmp_s = imtransform(nan_tmp, tform,'nearest',... 
                        'UData',[data.r(1) data.r(end)],...
                        'VData', [data.r(1) data.r(end)],...
                        'XData',[data.r(1) data.r(end)],...
                        'YData', [data.r(1) data.r(end)],...
                        'size', size(data.map));          
A = ~isnan(nan_tmp_s);
new_data.map(A) = nan;

end
