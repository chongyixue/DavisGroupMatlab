function new_data = map_deriv(data,der_order,smooth_width)

if isstruct(data)     
    img = data.map;
    e = data.e;
else      
    img = data;
    e = 1:size(img,3);
end
%new_data = data;
[nr nc nz] = size(img);

% determine new length of energy direction - 2 less for every order
% derivative
l = nz - 2*der_order;
map = zeros(nr,nc,l);

for i = 1:nr
    for j = 1:nc
        [map(i,j,:) e_new] = num_der2b(der_order,squeeze(squeeze(img(i,j,:))),e);
    end
end
if isstruct(data)
    new_data = data;
    new_data.map = map;
    new_data.e = e_new;
    new_data.ave = squeeze(squeeze(mean(mean(map))));
    new_data.var = [new_data.var '_deriv_' num2str(der_order)];
    new_data.ops{end+1} = ['Deriative of Order ' num2str(der_order)];
    img_obj_viewer2(new_data);
else
    new_data = map;
end
