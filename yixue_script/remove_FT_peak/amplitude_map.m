function new_data=amplitude_map(data)



if isstruct(data)
    tmp_data = data.map;
else
    tmp_data = data;
end

new_data = data;
tmp_data=abs(tmp_data);
if isstruct(data)
    new_data.map=tmp_data;
else
    new_data=tmp_data;
end





end