% 2019-6-24 YXC
% average radially using a mask

function rad_avg = radial_average_mask(FTmap,radius_pix,startangle,endangle)

% FTmap = ft;
% radius_pix = 11;
% 
[nx,~,~] = size(FTmap.map);

% asume center is always a pixel (true for FT in img_obj_viewer)
center_x = fix(nx/2)+1;
center_y = center_x;

% mask = zeros(nx,ny);
x = linspace(1,nx,nx);
% y = linspace(1,nx,nx);
[X,Y] = meshgrid(x);
X = X-center_x;
Y = Y-center_y;

angle = atan2(Y,X)*180/3.141592653589793;
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

% figure,imagesc(angle_mask);
% size(angle_mask)
dist = sqrt(X.^2+Y.^2);
mask = (dist <= (radius_pix+0.5));
mask2 = (dist >= (radius_pix-0.5)) ;
mask = mask.*mask2.*angle_mask;
dist_ring = abs(dist-radius_pix)*2;
inverse_ratio = 1-dist_ring;
mask = mask.*inverse_ratio;

value = mask.*FTmap.map;
value = sum(sum(value));
summ = sum(sum(mask));
rad_avg = value/summ;


end

