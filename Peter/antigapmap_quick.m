function antigapmap = antigapmap_quick(data, antigap)

img = data.map;
[nx, ny, nz] = size(img);
antigapmap = zeros(nx,ny,1);

for i=1:nx
    for j=1:ny
        
            sp = img(i,j,:);
            antigapmap(i,j,1) = ((mean(sp(antigap(3):antigap(4))) + mean(sp(antigap(5):antigap(6)))) /2 - mean(sp(antigap(1):antigap(2))))/mean(sp);
        
    end
end
change_color_of_STM_maps(antigapmap,'invert')
% figure, img_plot4(antigapmap)

end