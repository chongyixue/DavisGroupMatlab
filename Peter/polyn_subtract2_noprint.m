function new_data=polyn_subtract2(data,order)
[nr nc nz] = size(data.map);
w = ones(nr,nc);
new_map = zeros(nr,nc,nz);
for i = 1:nz
    p(i,:) = polyfitweighted2(data.r,data.r,data.map(:,:,i),order,w);
    new_map(:,:,i) = data.map(:,:,i) - polyval2(p(i,:),data.r,data.r);
end
new_data = data;
new_data.map = new_map;
new_data.ave = squeeze(mean(mean(new_data.map)));
new_data.var = [new_data.var '_' num2str(order) '_polysub'];
new_data.ops{end+1} = [num2str(order) ' order background subtraction'];
% img_obj_viewer2(new_data);
% display('New Data Created');
end