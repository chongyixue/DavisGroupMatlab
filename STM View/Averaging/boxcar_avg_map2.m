function new_data = boxcar_avg_map2(data,width)
new_data = data;

if width < 0 
    display('Width must be greater than or equal to 0');
    new_data = [];
    return;
elseif width == 0
    new_data = data;
    return;
end
w = round(width) ;
[nr nc nz] = size(data.map);
new_map = zeros(nr,nc,nz);

for i=1:nz    
    st_pt = max(1,i-w)
    end_pt = min(nz,i+w)
    new_map(:,:,i) = squeeze(mean(data.map(:,:,st_pt:end_pt),3));
end

if isstruct(data)
    new_data = data;
    new_data.map = new_map;
    new_data.ave = squeeze(squeeze(mean(mean(new_map))));
    new_data.var = [new_data.var '_boxcar_' num2str(w)];
    new_data.ops{end+1} = ['boxcar average width = ' num2str(width)];
    img_obj_viewer2(new_data);
else
    new_data = new_map;
end

end