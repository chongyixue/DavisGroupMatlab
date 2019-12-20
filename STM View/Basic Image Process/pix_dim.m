function new_data = pix_dim(data,new_pix_dim)
if isstruct(data)
    img = data.map; 
else
    img = data;
end
[nr nc nz] = size(img);

% for the future when also non square data will be considered.
[X Y] = meshgrid(1:nr,1:nc);

ry_int = linspace(1,nr,new_pix_dim);
rx_int = linspace(1,nc,new_pix_dim);
[XI YI] = meshgrid(ry_int,rx_int);


new_img = zeros(new_pix_dim,new_pix_dim,nz);
for k = 1:nz
    new_img(:,:,k) = interp2(X,Y,img(:,:,k),XI,YI,'linear');
end

if isstruct(data)
    new_data = data;
    new_data.map = new_img;
    new_data.r = linspace(data.r(1),data.r(end),new_pix_dim);
    new_data.var = [new_data.var '_rescale'];
    new_data.ops{end+1} = ['New Pixel Dimensions: ' num2str(nr) ' -> ' num2str(new_pix_dim) ] ;
    img_obj_viewer_test(new_data);
else
    new_data = new_img;
end
%display('New Data Created');

new_data = new_img;
end