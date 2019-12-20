function new_data = R_map(data)
[nr nc nz] = size(data.map);
if mod(nz,2) ~= 1
    fprintf('Not a valid map for R-map: even number of layers')
    return;
end
new_data = data;

mx  = find(data.e == 0);
mn = 1;
new_data.map = nan(nr,nc,mx);
new_data.map(:,:,mx) = data.map(:,:,mx);
new_data.e = data.e(mn:mx);

for i = 1:mx-1
    new_data.map(:,:,i) = data.map(:,:,end-i+1)./data.map(:,:,i);
end


