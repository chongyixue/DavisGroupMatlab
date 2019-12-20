function [dx, dy] = fit_singleimp_center(tdata, x, y, cx, cy)

map = tdata.map;

[nx, ny, nz] = size(map);

[xb,resnorm,residual]=complete_fit_2d_gaussian(map(y-cy:y+cy,x-cx:x+cx, :));

dx = x-cx+xb(2)-1;
dy = y-cy+xb(4)-1;

% [xl,resnorm,residual]=complete_fit_2d_gaussian(map(90:100, 84:94,:));
% 
% xcl = 84+xl(2)-1;
% ycl = 90+xl(4)-1;
% 
% [xr,resnorm,residual]=complete_fit_2d_gaussian(map(90:100, 93:103,:));
% 
% xcr = 93+xr(2)-1;
% ycr = 90+xr(4)-1;
% 
% dx = (xcl+xcr)/2;
% dy = (ycl+ycr)/2;


test = 1;


end