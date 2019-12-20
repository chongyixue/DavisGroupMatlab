function F = fourier_filter2d(data,width)
if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    tmp_data = data.map;
    F = data;
else % single data image
    [nr,nc,nz] = size(data);
    tmp_data = data;
end

gauss_mask1 = Gaussian(1:nr,1:nc,width,[floor(nr/2),floor(nc/2)],1);
gauss_mask2 = Gaussian(1:nr,1:nc,width,[floor(nr/2)+1,floor(nc/2)+1],1);
gauss_mask = (gauss_mask1 + gauss_mask2)/2;
for k = 1:nz
    tmp_data(:,:,k) = tmp_data(:,:,k).*gauss_mask;
end
if isstruct(data)
    F.map = tmp_data;
else
    F = tmp_data;
end
