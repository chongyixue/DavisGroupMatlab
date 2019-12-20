function fmap = fetese_filter_noise_pixel(map)

[nx, ny, ne] = size(map);

fmap = zeros(nx, ny, ne);

for i=2:nx-1
    for j=2:ny-1
        
        duml = [map(i-1,j,1), map(i+1,j,1), map(i,j-1,1), map(i,j+1,1),...
            map(i-1,j-1,1), map(i-1,j+1,1), map(i+1,j-1,1), map(i+1,j+1,1)];
        if abs ( map(i,j,1) - mean(duml) ) > 0.5*std(duml)
            fmap(i,j,1) = mean(duml);
        else
            fmap(i,j,1) = map(i,j,1);
        end
    end
end
        
figure, img_plot4(fmap);  
end