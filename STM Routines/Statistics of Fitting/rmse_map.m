function new_map = rmse_map(data_raw,data_fit)
[nr nc nz] = size(data_raw.map);
diff = (data_raw.map - data_fit.map).^2;
sum = zeros(nr,nc);
for k=1:nz
    sum = sum + (diff(:,:,k));
end
new_map = sqrt(sum/nz);
end