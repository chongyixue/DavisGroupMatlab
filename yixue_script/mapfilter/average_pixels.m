% 2018-8-21 Yi Xue Chong
% give a list of averaged pixels in a radius, sorted by energy. (-ve to
% +ve as given by datamap)
% datamap is like 80820a00_G
% refmap is something you get in the analyse code

function aver = average_pixels(x_pix,y_pix,datamap,refmap,radius)
pixels = size(datamap.map,2);
layers = size(datamap.map,3);

[xlist,ylist] = surrounding_pixels(x_pix,y_pix,pixels,radius);

len = length(xlist);

denominator = 0;
numerator = zeros(1,layers);
for p = 1:len
    x = xlist(p);
    y = ylist(p);
    if refmap.map(y,x,1) > 0.5
        denominator = denominator + 1;
        for lay = 1:layers
            numerator(lay) = numerator(lay) + datamap.map(y,x,lay);
        end
    end
end

if denominator ~= 0
    aver = numerator/denominator;
else
    aver = numerator;
end

end
