function new_data = gauss_subt(data,std,x0)
new_data = data;
[nr nc nz] = size(data.map);
for i = 1:nz
    new_data.map(:,:,i) = new_data.map(:,:,i) - new_data.map(:,:,i).*Gaussian(data.r,data.r,std,x0,1);
end
end