function coh_map(data)


map=data.map;
en=data.e;


[nx ny nz]=size(map);

cmap=zeros(nx,ny);


for i=1:nx
    for j=1:ny
        peaks=(mean(map(i,j,32:34))+mean(map(i,j,43:45)))/2;
        gap=mean(map(i,j,38:39));
        cmap(i,j)=peaks-gap;
    end
end

img_plot2(cmap);

figure; imagesc(cmap);


end