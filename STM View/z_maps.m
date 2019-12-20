function Z = z_maps(data)
[nr nc nz] = size(data.map);
if size(data.e,2)==1
    disp('Z-map not possible: 1 layer only');
    return;
end
%if ((abs(data.e(1)))==abs(data.e(end)) && (mod(nz,2)==1))
if ((abs(data.e(1)))==abs(data.e(end)))
    Z = data;   
    Z.map = zeros(nr,nc,nz);
    Z.map(:,:,ceil(nz/2)) = 1;
    for k = 1:floor(nz/2)
        if Z.e(1) > Z.e(end)
            display('here')
            Z.map(:,:,nz-k+1) = (data.map(:,:,k)./data.map(:,:,end-k+1));
            Z.map(:,:,k) =Z.map(:,:,nz-k+1);
        else
            Z.map(:,:,nz-k+1) = data.map(:,:,nz-k+1)./(data.map(:,:,k));
            Z.map(:,:,k) =Z.map(:,:,nz-k+1);
        end
    end
    Z.ave = squeeze(mean(mean(Z.map)));
    Z.var = 'Z';
    img_obj_viewer2(Z);
else
    disp('Z-map not possible');
    return;
end
        
end