function [nprft_data, nprft_topo, crdata, crtopo] = singleimpurity_nophase_onlycrop(data, topo, cco, varargin)
% data = map
% topo = topo
% cco = coordinates used for cropping


%% crop the topo and map 
if isempty(varargin)
    ctopo = topo.map(cco(1) : cco(2), cco(3) : cco(4));
else
    cmap2 = topo.map(cco(1) : cco(2), cco(3) : cco(4), :);
end
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

if isempty(varargin)
    crtopo.map = ctopo;
else
    crtopo.map = cmap2;
end

crtopo.r = rv;


new_data=polyn_subtract2(crdata,0);

cmap = new_data.map;

if isempty(varargin)
else
    new_data2=polyn_subtract2(crtopo,0);

    cmap2 = new_data2.map;
end

%% calculate the Fourier Transform of the cropped data, use sine window


for k = 1 : nz
    fftc_map(:,:,k) = fourier_transform2d_vb(cmap(:,:,k),'sine','complex','ft');
end


if isempty(varargin)

    fftc_topo = ( fourier_transform2d_vb(ctopo,'none','complex','ft') );

    figure, imagesc(real(fftc_topo))
    axis image

    figure, imagesc(imag(fftc_topo))
    axis image
else
    ml = varargin{1};
     
    for k = 1 : nz
        fftc_map2(:,:,k) = fourier_transform2d_vb(cmap2(:,:,k),'none','complex','ft');
    end
    
    figure, imagesc(real(fftc_map2(:,:,ml(1))))
    axis image

    figure, imagesc(imag(fftc_map2(:,:,ml(1))))
    axis image
end



q = r_to_k_coord(crdata.r);

% nprft = not phase resolved fourier transform
nprft_topo = crtopo;
nprft_data = crdata;

nprft_data.map = fftc_map;
nprft_data.r = q;

if isempty(varargin)
    nprft_topo.map = fftc_topo;
else
    nprft_topo.map = fftc_map2;
end
nprft_topo.r = q;

end