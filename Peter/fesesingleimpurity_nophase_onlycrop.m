function [nprft_data, nprft_topo, crdata, crtopo] = fesesingleimpurity_nophase_onlycrop(data, topo, cco)
% data = map
% topo = topo
% cco = coordinates used for cropping


%% crop the topo and map 

ctopo = topo.map(cco(1) : cco(2), cco(3) : cco(4));
cmap = data.map(cco(1) : cco(2), cco(3) : cco(4), :);

% compute the size of the cropped map
[nx, ny, nz] = size(cmap);

%% subtract the average background from the cropped map

% compute the new real space position vector in Angstroem
rv = topo.r(1:nx);


crdata = data;
crtopo = topo;

crdata.map = cmap;
crdata.r = rv;
crtopo.map = ctopo;
crtopo.r = rv;


new_data=polyn_subtract2(crdata,0);

cmap = new_data.map;

%% calculate the Fourier Transform of the cropped data, use sine window

fftc_topo = ( fourier_transform2d_vb(ctopo,'sine','complex','ft') );

figure, imagesc(real(fftc_topo))
axis image

figure, imagesc(imag(fftc_topo))
axis image

for k = 1 : nz
    fftc_map(:,:,k) = fourier_transform2d_vb(cmap(:,:,k),'sine','complex','ft');
end


q = r_to_k_coord(crdata.r);

% nprft = not phase resolved fourier transform
nprft_topo = crtopo;
nprft_data = crdata;

nprft_topo.map = fftc_topo;
nprft_topo.r = q;

nprft_data.map = fftc_map;
nprft_data.r = q;


end