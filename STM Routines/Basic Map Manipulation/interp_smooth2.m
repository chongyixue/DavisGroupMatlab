function new_data = interp_smooth2(data,px_count)
%px_count is an integer

new_data = data;
[nr nc nz] = size(data.map);

[X,Y] = meshgrid(1:nc,1:nr);
new_map = zeros(px_count*nr-1,px_count*nc-1,nz);
[XI,YI] = meshgrid(1:1/px_count:nc,1:1/px_count:nr);
for k = 1:nz    
   new_map(:,:,k) = interp2(X,Y,data.map(:,:,k),XI,YI);
    %new_map(:,:,k) = tmp;
end
new_data.map = new_map;
[nr nc nz] = size(new_data.map);
new_data.r = linspace(data.r(1),data.r(end),nr);
end
    
    