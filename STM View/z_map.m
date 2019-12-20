function Z = z_map(data)
[nr nc nz] = size(data.map);
if size(data.e,2)==1
    disp('Z-map not possible: 1 layer only');
    return;
end
if ((abs(data.e(1)))==abs(data.e(end)) && (mod(nz,2)==1))
    Z = data;
    Z.e = abs(data.e(ceil(nz/2):end));
    new_nz = size(Z.e,2);
    Z.map = zeros(nr,nc,new_nz);
    Z.map(:,:,1) = data.map(:,:,ceil(nz/2));
    for k = 1:new_nz-1
        Z.map(:,:,new_nz-k+1) = (data.map(:,:,k)./data.map(:,:,end-k+1));
    end
    Z.ave = squeeze(mean(mean(Z.map)));
    Z.var = 'Z';
else
    disp('Z-map not possible');
    return;
end
        
end