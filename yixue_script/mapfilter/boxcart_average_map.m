% boxcart filter map
% 2018/9/17

map = obj_80917a00_G_crop_0_polysub_ft_amplitude;
newmap = map;
refmap = map;

pixels = size(map.map,2);
layers = size(map.map,3);

for x_pix = 1:pixels
    for y_pix = 1:pixels
        [xlist,ylist] = surrounding_pixels(x_pix,y_pix,pixels,1);
        xlist(length(xlist+1)) = x_pix;
        ylist(length(ylist+1)) = y_pix;
        
        len = length(xlist);
       
        
        denominator = 0;
        numerator = zeros(1,layers);
        for p = 1:len
            x = xlist(p);
            y = ylist(p);
            
            denominator = denominator + 1;
            for lay = 1:layers
                numerator(lay) = numerator(lay) + map.map(y,x,lay);
            end
            
        end
        aver = numerator/denominator;
        
        newmap.map(y_pix,x_pix,:)=aver;
        
    end
end
img_obj_viewer_test(newmap)