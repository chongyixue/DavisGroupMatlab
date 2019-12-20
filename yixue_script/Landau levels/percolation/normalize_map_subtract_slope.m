% 2019-4-16 YXC

function map2 = normalize_map_subtract_slope(map)

[nx,ny,~] = size(map.map);
for x = 1:nx
    for y = 1:ny
        data = squeeze(map.map(x,y,:));
        first = data(1);
        last = data(end);
        len = length(data);
        div = linspace(first,last,len)';
%         size(data)
%         size(div)
        data = data-div;
        
%         data = data(16:end); % remove first few points that overloaded
        maxi = max(data);
        mini = min(data);
%         size(map.map(x,y,:))
%         size(map.map(x,y,:)-mini)_
%         map.map(x,y,:) = (map.map(x,y,:)-mini)./(maxi-mini);
        map.map(x,y,:) = (data-mini)./(maxi-mini);
    end
end

map.ave = squeeze(mean(mean(map.map,1)));

map.name = 'normalized_subtract_slope';
img_obj_viewer_yxc(map)

%FT
subback0map = polyn_subtract(map,0,3); %something on varargin(3):no-popup
FTmap = fourier_transform2d(subback0map,'sine','amplitude','ft');
FTmap.ave = [];
FTmap.var = [FTmap.var '_ft_amplitude'];
FTmap.ops{end+1} = 'Fourier Transform: amplitude - sine window - ft direction';
img_obj_viewer_test(FTmap);


map2 = map;


end