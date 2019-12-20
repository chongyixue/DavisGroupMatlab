%%%%%%%
% CODE DESCRIPTION: When in a map the required coordinate does not land on
% a pixel this code produce a weighted average of the nearest pixels to
% interpolate the value at the coordinate position.  The interpolation uses
% the 4 closest pixels.  If the given coordinate is already a valid  pixel
% then the algorithm gives back the value of the img at that pixel and
% there is interpolation.
%
%INPUTS: 2D image, px_x,px_y, are the coordinates (in pixel scale) for which the img value
%must be determined (not necessarily coinciding with an actual pixel). i.e.
%px_x correspond to the column, px_y corresponds to the row
%   
% CODE HISTORY
%
% 080418 MHH Created
% 

function px_val = pixel_val_interp(img,px_x,px_y)
%determine closest pixels by finding closest grid points
x1 = ceil(px_x);
x2 = floor(px_x);
y1 = ceil(px_y);
y2 = floor(px_y);
%perform 1D or 2D interpolation to determine values of image at coordinates
if x1 ~= x2 && y1 ~=y2   
    [X Y] = meshgrid([x2 x1],[y2 y1]);
    Z = img(y2:y1,x2:x1);
    [Xi Yi] = meshgrid([x2 px_x x1],[y2 px_y y1]);
    Zi = interp2(X,Y,Z,px_x,px_y,'linear' );
    px_val = Zi;
elseif x1 == x2  && y1 ~= y2
    Z = img(y2:y1,x1);
    Zi = interp1(y2:y1,Z,[px_y],'linear');
    px_val = Zi;
elseif y1 == y2 && x2 ~= x1
    Z = img(y1,x2:x1);
    Zi = interp1(x2:x1,Z,[px_x],'linear');
    px_val = Zi;
else
    px_val = img(px_y,px_x);
end   
end
