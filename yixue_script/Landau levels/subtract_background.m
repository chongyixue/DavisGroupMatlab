% YXC 2019-2-25
% choose points that does not have obvious LL points
% i.e. minima of LL + straight line regions
% to fit a 5 deg polynomial then subtract from map to a new map
% for every spectra

function subtractedmap = subtract_background(map)

subtractedmap = map;
[nx,ny,nz] = size(map.map);

for x = 1:nx
    for y = 1:ny
        spec = map.map(x,y,:);
        spec2(:) = spec(1,1,:);
        [~,subtractedmap.map(x,y,:)] = subtract_single_spectra_bck(map,map.e,spec2');
    end
end

subtractedmap.name = [subtractedmap.name , '_bcksub'];
for k = 1:nz
    subtractedmap.ave(k) = mean(mean(subtractedmap.map(:,:,k)));
end

