function new_img = polyn_subtract_img(img,order)
[nr nc nz] = size(img);
r = 1:nr;
c = 1:nc;
w = ones(nr,nc);
new_img = zeros(nr,nc,nz);
for i = 1:nz
    p(i,:) = polyfitweighted2(c,r,img(:,:,i),order,w);
    new_img = img(:,:,i) - polyval2(p(i,:),c,r);
end
%new_data = data;
%new_data.map = new_map;
%new_data.ave = squeeze(mean(mean(new_data.map)));
%new_data.var = [new_data.var '_' num2str(order) '_polysub'];
%new_data.ops{end+1} = [num2str(order) ' order background subtraction'];
%img_obj_viewer2(new_data);
img_plot2(new_img);
display('New Data Created');
end