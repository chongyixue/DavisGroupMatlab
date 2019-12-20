function [prft_data] = singleimpurityshiftcenter(lfdata, lftopo, dco, cs, varargin)
% lfdata = LF corrected map
% lftopo = LF corrected topo
% dco = defect center coordinates
% cs = symmetrical crop size around defect center
% 

%% using the exact double (not integer) pixel coordinates of the defect / Fe-atom 
%% perform a shift of the data to the origin for the purpose of the FT before 
%% cropping the fov

[nx, ny, nz] = size(lfdata.map);

if mod(nx, 2) == 0
    ndx = nx/2 + 1;
    ndy = ny/2 + 1;
else
    ndx = (nx-1)/2 + 1;
    ndy = (ny-1)/2 + 1;
end

% center / origin in integer pixel coordinates
cx = ndx;
cy = ndy;

% Create meshgrid 
[X,Y]=meshgrid(1:1:nx,1:1:ny,1);

xdata(:,:,1)=X;
xdata(:,:,2)=Y;

% using the exact coordinates of the defect compute the required shift from
% the center
gx = dco(1);
gy = dco(2);
sx = gx - cx;
sy = gy - cy;

%%

% sfctx, sfcty, shift functions in Fourier space
sfctx = exp(1i*2*pi*sx/nx*(X-cx));
sfcty = exp(1i*2*pi*sy/ny*(Y-cx));
    


% compute shifted layers of conductance map
for k = 1 : nz
    fft_map(:,:,k) = fourier_transform2d_vb( ifftshift( lfdata.map(:,:,k) ) ,'none','complex','ft');
    fft_map(:,:,k) = fft_map(:,:,k) .* sfctx .* sfcty;
end

for k = 1 : nz
    sft_map(:,:,k) = fourier_transform2d_vb( fft_map(:,:,k),'none','real','ift');
    sft_map(:,:,k) = fftshift( sft_map(:,:,k) );
end



%% crop the LF corrected topo and map after the defect has been shifted to the 
%% center / origin for purpose of FT

% defect should now be exactly in center after having been shifted
dx = ndx;
dy = ndy;

% crop the shifted conductance map and topo or current map

cmap = sft_map(dx-cs : dx + cs, dy -cs : dy + cs, :);





% compute the size of the cropped map
[nx, ny, nz] = size(cmap);

% compute the new center of cropped map
ndx = (nx-1)/2 + 1;
ndy = (ny-1)/2 + 1;


%% subtract the average background from the cropped conductance map, and from the cropped current map if used instead of topo

% compute the new real space position vector in Angstroem
rv = lftopo.r(1:nx);


clfdata = lfdata;
% clftopo = lftopo;

clfdata.map = cmap;
clfdata.r = rv;





new_data=polyn_subtract2_noprint(clfdata,0);

cmap = new_data.map;

% if isempty(varargin)
% else
%     new_data2=polyn_subtract2(clftopo,0);
% 
%     cmap2 = new_data2.map;
% end


%% multiply with sine window function first before doing ifftshift

x = linspace(0,pi,nx);
y = linspace(0,pi,ny);
z = sin(x)'*sin(y);

filtmap = zeros(nx, ny, nz);

for k=1:nz
    filtmap(:,:,k) = cmap(:,:,k).*z';
    filtmap(:,:,k) = ifftshift( filtmap(:,:,k) );
end




%% calculate the Fourier Transform of the cropped, shifted, and windowed data

for k = 1 : nz
    fftc_map(:,:,k) = fourier_transform2d_vb(filtmap(:,:,k),'none','complex','ft');
%    fftamp_map(:,:,k) = fourier_transform2d_vb(filtmap(:,:,k),'none','amplitude','ft');
end




q = r_to_k_coord(clfdata.r);

% prft = phase resolved fourier transform
% prft_topo = clftopo;
prft_data = clfdata;

prft_data.map = fftc_map;
prft_data.r = q;



end