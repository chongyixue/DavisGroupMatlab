function new_data = nem_dom_mean_subt(data)

if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    tmp_map = data.map;    
else % single data image
    [nr,nc,nz] = size(data);
    tmp_map = data;
end
new_map = zeros(nr,nc,nz);
for k=1:nz
    tmp_lyr = tmp_map(:,:,k);
    mean_val = mean(mean(tmp_lyr(tmp_lyr~=0)));
    tmp_lyr(tmp_lyr~=0) = tmp_lyr(tmp_lyr ~=0) - mean_val;
    new_map(:,:,k) = tmp_lyr;
end
if isstruct(data)
    new_data = data;
    new_data.map = new_map;
    new_data.ave = squeeze(mean(mean(new_data.map)));
    new_data.var = [new_data.var '_zm'];
    new_data.ops{end+1} = 'Subtract Mean Value of Domain Image';
    img_obj_viewer2(new_data);
    display('New Data Created');
else
    new_data = new_map;
end
end
