function [gsdata, gdata] = suppress_defects_with_gaussians(data, dlist, gsig)

gdata = data;
gsdata = data;

map = data.map;
[nx, ny, nz] = size(map);
allgauss = zeros(nx, ny);
gmap = zeros(nx, ny, nz);
gsmap = zeros(nx, ny, nz);

[X,Y]=meshgrid(1:1:max(size(map(:,:,1),2)),1:1:max(size(map(:,:,1),1)));
xdata(:,:,1)=X;
xdata(:,:,2)=Y;


for i=1:length(dlist(1,:))
    
    comx = dlist(1, i);
    comy = dlist(2, i);
    x0 = [0.99; comx; gsig; comy; gsig; 0; 0];

    singauss=twodgauss(x0,xdata);
    allgauss = allgauss + singauss;
end

img_plot2(allgauss)

for i=1:nz
    gmap(:,:,i) = map(:,:,i) .* allgauss;
    gsmap(:,:,i) = map(:,:,i) - gmap(:,:,i);
end

gdata.map = gmap;
gsdata.map = gsmap;

end