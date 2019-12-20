function [varagrout]=hex_pixel_LCM(maxpixel,tolerance)
%maxpixel: the maximum pixel you are willing to put in one unit cell
%tolerance: deviation from full pixel allowed
%2018/1/23

height = 2*(3^0.5);
width = 1;

p=1;

for n = 1:maxpixel
    if mod(height*n,1)<tolerance
        varagrout{p}=n;
        p=p+1;
    end
end