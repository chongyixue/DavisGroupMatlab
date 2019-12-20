function [dx, dy] = determine_singleimp_center_double_peak(tdata, ml, sx, sy, cx, cy, sx2, sy2, cx2, cy2, varargin)

map = tdata.map(:,:,ml);

if isempty(varargin)
else
    if strcmp(varargin{1}, 'invert')==1
        
        map = 1./map;
    end
end


[nx, ny, nz] = size(map);

[xl,resnorm,residual]=complete_fit_2d_gaussian(map(sy-cy:sy+cy, sx-cx:sx+cx,:));

xcl = sx-cx+xl(2)-1;
ycl = sy-cy+xl(4)-1;

[xr,resnorm,residual]=complete_fit_2d_gaussian(map(sy2-cy2:sy2+cy2, sx2-cx2:sx2+cx2,:));

xcr = sx2-cx2+xr(2)-1;
ycr = sy2-cy2+xr(4)-1;

dx = (xcl+xcr)/2;
dy = (ycl+ycr)/2;


test = 1;


end