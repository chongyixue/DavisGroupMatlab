function RGB = RGB_convert(data,clmap,lower,upper)
cmap = colormap(clmap);
clrange = size(cmap);
clrange = clrange(1);
[sx sy sz] = size(data.map);

for k = 21:21
    [min, max] = get_colormap_limits(data.map(:,:,k),lower,upper,'h');
    clrlist = linspace(min,max,clrange);
    er = abs(clrlist(1) - clrlist(2));
    for i=1:sx
        for j=1:sy
            map_val = data.map(i,j,k);
            [x,y] = find(clrlist >= map_val - er & clrlist <= map_val + er);            
            xsize = size(x);        
            if xsize(2) > 1
                if ((map_val - clrlist(y(1))) - (clrlist(y(2)) - map_val)) > 0
                  %  yes'                    
                    RGB(i,j,1,:) = cmap(y(2),:);
                end
            else
               % 'no'
                RGB(i,j,1,:) = cmap(y(1),:);
            end
        end
    end
end
end
    
    

