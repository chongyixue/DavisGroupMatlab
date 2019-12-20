function new_data = boxcar_avg_map(data,width)
new_data = data;
[nr nc nz] = size(new_data.map);
for i = 1:nr
    for j = 1:nc
        new_data.map(i,j,:) = boxcar_avg(squeeze(squeeze(new_data.map(i,j,:))),width);
    end
end
new_data.ops{end+1} = ['boxcar average width = ' num2str(width)];
img_obj_viewer2(new_data);
end