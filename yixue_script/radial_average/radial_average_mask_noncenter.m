% 2020-5-21 YXC
% average radially using a mask, but not necesarily center at center
% center px given by cx cy

function [rad_avg,mask] = radial_average_mask_noncenter(map,cx,cy,radius_pix,startangle,endangle)

center_x = cx;
center_y = cy;

nx = size(map.map,1);
x = linspace(1,nx,nx);
[X,Y] = meshgrid(x);
X = X-center_x;
Y = Y-center_y;

angle = atan2(Y,X)*180/pi;
angle = mod(angle,360);

%add angle to mask
startangle = mod(startangle,360);
endangle = mod(endangle,360);


% angle_mask is 1 if include
if startangle == endangle
    angle_mask = angle<400; %(just all included)
elseif endangle<startangle
    angle_mask = or(angle>startangle,angle<endangle);
else
    angle_mask = and(angle>startangle,angle<endangle);
end

dist = sqrt(X.^2+Y.^2);
mask = (dist <= (radius_pix+0.5));
mask2 = (dist >= (radius_pix-0.5));

mask = mask.*mask2.*angle_mask;
% figure,imagesc(mask)
dist_ring = abs(dist-radius_pix)*2;

inverse_ratio = 1-dist_ring;
mask = mask.*inverse_ratio;

value = mask.*map.map;
value = sum(sum(value));
summ = sum(sum(mask));
rad_avg = value/summ;



end





