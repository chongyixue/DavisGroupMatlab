%%%%%%%
% CODE DESCRIPTION: Rotates a map by angle specified in degrees by the
% user.  The out is a set of new axes which form a grid with the same
% number of points as the original axes.  
%   
% CODE HISTORY
%
% 080125 MHH  Created
%
%
%%%%%%%

function[new_x_coord,new_y_coord,new_map] = rotate_map(map,x_coord,y_coord,degree)

angle = degree*pi/180;

if mod(angle,360) == 0
    new_map = map;
    new_x_coord = x_coord;
    new_y_coord = y_coord;
    return;
end

[grid_x,grid_y] = meshgrid(x_coord,y_coord);
rot_mat = [cos(angle) -sin(angle); sin(angle) cos(angle)];

[sy,sx,sz] = size(map);

%generate new rotated coordinates of all grid points on the map
%the transformed grid point is still associated with the same map value
for i=1:sx
    for j=1:sy
       temp = rot_mat*[x_coord(i) y_coord(j)]';
       new_coord(i,j,:) = temp(:);
    end        
end
%take transpose to since x and y coordinates are switched in maps
new_coord(:,:,1) = new_coord(:,:,1)'; 
new_coord(:,:,2) = new_coord(:,:,2)';

% %set output values
% new_x_coord = new_coord(:,:,1);
% new_y_coord = new_coord(:,:,2);

%determine the meshing of new grid based on size and mesh size of old grid

%find mean spacing between grid points
mean_x_space = mean(x_coord(2:end) - x_coord(1:end-1));
mean_y_space = mean(y_coord(2:end) - y_coord(1:end-1));

%find limits of new grid -> will use this to set limits of new axes
max_x = max(max(new_coord(:,:,1)));
min_x = min(min(new_coord(:,:,1)));
max_y = max(max(new_coord(:,:,2)));
min_y = min(min(new_coord(:,:,2)));

% generate new coordinates for map
new.x_coord = linspace(min_x,max_x,length(x_coord));
new_x_coord = new.x_coord;
new.y_coord = linspace(min_y,max_y,length(y_coord));
new_y_coord = new.y_coord;

[X,Y] = meshgrid(new.x_coord,new.y_coord);
for k = 1:sz
new.map(:,:,k) = griddata(new_coord(:,:,1),new_coord(:,:,2),map(:,:,k), X,Y,...
    'linear',{'Qt','Qbb','Qc','Qz'});
end
new.map(isnan(new.map)) = 0;
new_map = new.map;
end