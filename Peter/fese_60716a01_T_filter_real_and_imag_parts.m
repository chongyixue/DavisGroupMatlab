

%% try to suppress atomic contrast


[nx, ny, nz] = size(real_prft_topo.map);

% mask = double( circle_mask( nx, 56, 56, 10 ) );

[X,Y]=meshgrid(1:1:nx,1:1:ny,1);
xdata(:,:,1)=X;
xdata(:,:,2)=Y;

 x0 = [1; 451; 15; 451; 15; 0; 0];

mask=twodgauss(x0,xdata);
figure, imagesc(mask)

repmask = repmat(mask, 1, 1, nz);

real_prft_topo.cpx_map = real_prft_topo.map .* repmask;
imag_prft_topo.cpx_map = 1i*(imag_prft_topo.map) .* repmask;

real_prft_topo_rspace = fourier_transform2d(  real_prft_topo  ,'none','real','ift');
imag_prft_topo_rspace = fourier_transform2d(  imag_prft_topo  ,'none','real','ift');

real_prft_topo_rspace.map = ifftshift( real_prft_topo_rspace.map);
imag_prft_topo_rspace.map = ifftshift( imag_prft_topo_rspace.map);