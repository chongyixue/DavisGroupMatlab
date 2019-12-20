function [real_data, imag_data] = q_fftshift(data, qx, qy)

[nx, ny, nz] = size(data.map);

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

sx = cx - qx;
sy = cy - qy;

%%
% Create meshgrid 
[X,Y]=meshgrid(1:1:nx,1:1:ny,1);

xdata(:,:,1)=X;
xdata(:,:,2)=Y;

% sfctx, sfcty, shift functions in Fourier space
sfctx = exp(1i*2*pi*(nx/4)/nx*(X-cx));
sfcty = exp(1i*2*pi*(ny/4)/ny*(Y-cy));
%%

% compute shifted layers of map

new_map = zeros(nx, ny, nz);
new_map2 = zeros(nx, ny, nz);
new_map3 = zeros(nx, ny, nz);
new_map4 = zeros(nx, ny, nz);

for k = 1 : nz
    
    dummy = fourier_transform2d_vb( ( data.map(:,:,k) ) ,'sine','complex','ft');
    dummy = dummy .* sfctx .* sfcty;
    
%     new_map(:,:,k) = data.map(:,:,k) .* sfctx .* sfcty;
%     new_map(:,:,k) = ifftshift( fourier_transform2d_vb( ( new_map(:,:,k) ) ,'sine','complex','ft') );
    
    new_map(:,:,k) = circshift(dummy, [sy, sx]);
    figure, imagesc(abs(new_map(:,:,k)));
    new_map2(:,:,k) = conj( dummy );
    figure, imagesc(abs(new_map2(:,:,k)));
    
    
    new_map3(:,:,k) = real(new_map(:,:,k) .* new_map2(:,:,k));
    new_map4(:,:,k) = imag(new_map(:,:,k) .* new_map2(:,:,k));
end

real_data = data;
imag_data = data;


real_data.map = new_map3;
imag_data.map = new_map4;


end