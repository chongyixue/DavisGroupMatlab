function new_data = split_map(data,first_pt,last_pt)

st_pt = first_pt; end_pt = last_pt;
if first_pt > last_pt
    st_pt = last_pt;
    end_pt = first_pt;
end     

new_data = data;
[nr nc nz] = size(new_data.map);
if st_pt < 1 || end_pt > nz
    display('Invalid Layer values to split data set');
    return;
end
new_data.map = new_data.map(:,:,st_pt:end_pt);
new_data.e = new_data.e(st_pt:end_pt);


end