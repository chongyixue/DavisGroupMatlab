function [cm_x cm_y] = center_of_mass(img,varargin)

if nargin == 1
    [nr nc] = size(img);
    rx = 1:nr; ry = 1:nc;
else
    rx = varargin{2}; ry = varargin{2};
end
    
[nr nc] = size(img);

total_mass = sum(sum(img));

weighted_x = 0;
weighted_y = 0;

for i = 1:nr
    weighted_x = weighted_x + sum(rx.*squeeze(img(i,:)));
end

for i = 1:nc
    weighted_y = weighted_y + sum(ry'.*squeeze(img(:,i)));
end
    
cm_x = weighted_x/total_mass; cm_y = weighted_y/total_mass; 

img_plot2(img); hold on; plot(cm_y,cm_x,'rx')
cm_x
cm_y

end