function new_data = px4_avg(data)
if isstruct(data)
    map = data.map;
else
    map = data;
end

[nr nc nz] = size(map);
%assuming map is even dimensioned
% changed to floor(nr/2) for the case that it is not even dimensions -
% 05/22/14 Peter Sprau
new_map = zeros(floor(nr/2), floor(nc/2),nz);
for i=1:floor(nr/2)
    for j=1:floor(nc/2)
        ix = 2*i -1;
        jy = 2*j -1;
        new_map(i,j,:) = (data.map(ix,jy,:)+ data.map(ix+1,jy,:) + data.map(ix,jy+1,:) +...
                        data.map(ix+1,jy+1,:))/4;
    end
end
if isstruct(data)
    new_data = data;
    new_data.map = new_map;
    new_data.r = data.r(1:2:end);
    new_data.var = [new_data.var '_4px-avg'];
    new_data.ops{end+1} = '4 pixel average';
    img_obj_viewer2(new_data);
else
    new_data = map;
end