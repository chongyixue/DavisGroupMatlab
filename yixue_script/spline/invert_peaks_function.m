%courtesy Rahul Sharma 2018-8-31
%Masks everything but selected Gaussian peak areas and inverse FT
%changed into function 2018/10/10 YXC

function [map2,mask] = invert_peaks_function(map,real_or_abs,gauss_sigma,varargin)

x = varargin{1};
points = size(varargin,2)/2;
if points<1
    q = x;
    clear x;
    points = length(q)/2;
    for k=1:length(q)
        x{k} = q(k);
    end
end


pix_x = zeros(points);
pix_y = zeros(points);

for k = 1:points*2
    if mod(k,2) == 1
        pix_x(round((k+1)/2))=x{k};
    else
        pix_y(round(k/2)) = x{k};
    end
end
    
energy = map.e;
map = map.map;
ft_data = fourier_transform2d_vb(map,'none','complex','ft');
[nr,nc,nk] = size(ft_data);

[X,Y]=meshgrid(1:1:nc,1:1:nr,1);
xdata(:,:,1)=X;
xdata(:,:,2)=Y;

npeaks = points;
%p contains i and j coordinates.  of each peak [i;j]
p = zeros(points,2);
for k = 1:npeaks
    p(k,:) = [pix_x(k);pix_y(k)];
end

% gauss_sigma = 5;
gm = 0;
gm_net = 0;

for i=1:npeaks
    x = [1,p(i,1),gauss_sigma,p(i,2),gauss_sigma,0,0];%7-d vector of features that go into twodgauss
    gm = twodgauss(x,xdata);
    gm_net = gm_net+gm;
end

name = 'peaks_IFT';
% figure, imagesc(gm_net), axis square
gm_net = repmat(gm_net,[1 1 nk]);
data_masked_net = ft_data.*gm_net;
mask = mat2STM_Viewer(abs(data_masked_net),energy(1),energy(nk),length(energy),'mask');
ift_peaks = fourier_transform2d_vb(data_masked_net,'none',real_or_abs,'ift');%real or abs?
map2 = mat2STM_Viewer(ift_peaks,energy(1),energy(nk),length(energy),name);

img_obj_viewer_test(map2)
img_obj_viewer_test(mask)

