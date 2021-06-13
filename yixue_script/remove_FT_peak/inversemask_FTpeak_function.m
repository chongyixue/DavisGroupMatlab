% 2020-4-26 YXC

% given coordinates of kspace and gaussian mask size, keep those peaks


function newdata = inversemask_FTpeak_function(data,Gausssize,varargin)

if isstruct(data)
    [~,nr, nz] = size(data.map);
else
    [~,nr, nz] = size(data);
end

% center = (nr+1)/2;
gw = Gausssize;

npoints = round(length(varargin))/2;
xx = zeros(npoints);
yy = zeros(npoints);

for i=1:npoints
    xx(i) = varargin{i*2-1};
    yy(i) = varargin{i*2};
end


mask = zeros(nr,nr,1);

addtoshiftopposite = 2-mod(nr,2);

for i=1:npoints
    x = xx(i);
    y = yy(i);
    mask = mask + Gaussian_v2(1:nr,1:nr,gw,gw,0,[x,y],1);
%     mask = mask + Gaussian_v2(1:nr,1:nr,gw,gw,0,[nr-x,nr-y],1);
    mask = mask + Gaussian_v2(1:nr,1:nr,gw,gw,0,[nr-x+addtoshiftopposite,nr-y+addtoshiftopposite],1);
end

maxx = max(max(mask));
if maxx ~= 0
    mask = mask/maxx;
end

mask3D = zeros(nr,nr,nz);
for i = 1:nz
    mask3D(:,:,i) = mask;
end

% figure,imagesc(mask);

FTcomplex = fourier_transform2d(data,'none','complex','ft');
if isstruct(FTcomplex)
    FTcomplex.map = FTcomplex.map.*mask3D;
    FTcomplex.cpx_map = FTcomplex.cpx_map.*mask3D;
    FTcomplex.rel_map = FTcomplex.rel_map.*mask3D;
    FTcomplex.img_map = FTcomplex.img_map.*mask3D;
    FTcomplex.apl_map = FTcomplex.apl_map.*mask3D;
    FTcomplex.pha_map = FTcomplex.pha_map.*mask3D;
    
    
    
else
    FTcomplex = FTcomplex.*mask3D;
end

newdata = fourier_transform2d(FTcomplex,'none','real','ift');
newdata.ave = average_spectrum_map(newdata);

% img_obj_viewer_test(fourier_transform2d(FTcomplex,'none','imaginary','ift'));
% img_obj_viewer_test(fourier_transform2d(FTcomplex,'none','phase','ift'));
% img_obj_viewer_test(fourier_transform2d(FTcomplex,'none','real','ift'));




end





