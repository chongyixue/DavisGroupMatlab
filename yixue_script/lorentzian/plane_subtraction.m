% 2019-6-24 YXC
% take fitted landau level map and fit a plane background to it
% return the map which has plane subtracted to it

% map = llmap_combine_filtered_90228;
% subtractedmap = map;
% subtractedmap.name = 'plane_subtracted_90228';
% 
% [nx,ny,nz] = size(map.map);
% 
% X = meshgrid(linspace(1,nx,nx));
% Y = meshgrid(linspace(1,ny,ny));
% 
% 
% 
% for layer = 1:nz
%     Z = map.map(:,:,layer);
%     XYZ = [X(:) Y(:) Z(:)];
%     [n,V,p] = affine_fit(XYZ);
%     antiplane = (X.*V(1) + Y.*V(2))/V(3);
%     subtractedmap.map(:,:,layer) = map.map(:,:,layer)+ antiplane;
%     % subtractedmap.map(:,:,1) =  antiplane;
% end
% 
% img_obj_viewer_test(subtractedmap);
% img_obj_viewer_test(map);

% map = crop;
% map = llmap_combine_filtered_90228;
map = llmap_combine_filtered_90227;
subtractedmap = map;
subtractedmap.name = 'plane_subtracted';

[nx,ny,nz] = size(map.map);

[X,Y] = meshgrid(linspace(1,nx,nx));
% Y = meshgrid(linspace(1,ny,ny))';



for layer = 1:nz
    Z = map.map(:,:,layer);
    XYZ = [X(:) Y(:) Z(:)];
    C = planefit(X,Y,Z);
    plane = X.*C(1) + Y.*C(2)+C(3);
    subtractedmap.map(:,:,layer) = map.map(:,:,layer)- plane;
    % subtractedmap.map(:,:,1) =  antiplane;
end

img_obj_viewer_test(subtractedmap);
img_obj_viewer_test(map);



