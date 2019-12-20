function new_data = binary_domains(data)
if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    tmp_map = data.map;    
else % single data image
    [nr,nc,nz] = size(data);
    tmp_map = data;
end

new_map = sign(tmp_map);

if isstruct(data)
    new_data = data;
    new_data.map = new_map;
    new_data.avg = squeeze(mean(mean(new_map)));
    new_data.var = [new_data.var '_binary'];
    new_data.ops{end+1} = 'Swith to Binary Representation +1 or -1';
    img_obj_viewer2(new_data);
    display('New Data Created');
else
    new_data = new_map;
end

end