


%% Star shaped defect
% %
% [prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(obj_50501A01_T_LF, obj_50501A01_T_LF, [922, 651], 40);


% %% Triangle shaped defect Te site
% 
% 
% [prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(obj_50501A01_T_LF, obj_50501A01_T_LF, [701, 506], 40);
% 
% 
% %% Triangle shaped defect Sb site
% 
% 
% [prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(obj_50501A01_T_LF, obj_50501A01_T_LF, [701, 510], 40);

%% filter the real and imaginary part and inverse FT

[nx, ny, nz] = size(real_prft_topo.map);

% mask = double( circle_mask( nx, 56, 56, 10 ) );

[X,Y]=meshgrid(1:1:nx,1:1:ny,1);
xdata(:,:,1)=X;
xdata(:,:,2)=Y;

 x0 = [1; 41; 5; 41; 5; 0; 0];

mask=twodgauss(x0,xdata);
figure, imagesc(mask)

repmask = repmat(mask, 1, 1, nz);

real_prft_topo.cpx_map = (real_prft_topo.map) .* repmask;
imag_prft_topo.cpx_map = 1i*(imag_prft_topo.map) .* repmask;

figure, imagesc(abs(real_prft_topo.cpx_map))
figure, imagesc(abs(imag_prft_topo.cpx_map))

real_prft_topo_rspace = fourier_transform2d(  real_prft_topo  ,'none','real','ift');
imag_prft_topo_rspace = fourier_transform2d(  imag_prft_topo  ,'none','real','ift');

real_prft_topo_rspace.map = ifftshift( real_prft_topo_rspace.map);
imag_prft_topo_rspace.map = ifftshift( imag_prft_topo_rspace.map);