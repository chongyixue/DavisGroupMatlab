

%% try to suppress atomic contrast


[nx, ny, nz] = size(obj_51107A00_G_LFC.map);

% mask = double( circle_mask( nx, 56, 56, 10 ) );

[X,Y]=meshgrid(1:1:nx,1:1:ny,1);
xdata(:,:,1)=X;
xdata(:,:,2)=Y;

 x0 = [1; 143; 5; 143; 5; 0; 0];

mask=twodgauss(x0,xdata);
figure, imagesc(mask)

repmask = repmat(mask, 1, 1, nz);

obj_51107A00_G_LFC_FT.cpx_map = obj_51107A00_G_LFC_FT.map .* repmask;

obj_51107A00_G_LFC_filt = fourier_transform2d(  obj_51107A00_G_LFC_FT  ,'none','real','ift');

obj_51107A00_G_LFC_filt.map = ifftshift( obj_51107A00_G_LFC_filt.map);
