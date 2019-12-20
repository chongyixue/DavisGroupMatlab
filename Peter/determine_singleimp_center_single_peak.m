function [dx, dy] = determine_singleimp_center_single_peak(tdata, ml, sx, sy, cx, cy, varargin)

map = tdata.map(:,:,ml);

if isempty(varargin)
else
    if strcmp(varargin{1}, 'invert')==1
        if min( min( map ) ) < 0
            map = map + abs( min( min( map ) ) );
        end
        map = 1./map;
    end
end

[nx, ny, nz] = size(map);

[xb,resnorm,residual]=complete_fit_2d_gaussian(map(sy-cy:sy+cy, sx-cx:sx+cx,:));

dx = sx-cx+xb(2)-1;
dy = sy-cy+xb(4)-1;


test = 1;


end