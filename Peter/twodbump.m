function F = twodbump(x,xdata)
%% Fitting function for a two-dimensional Gaussian with possibly rotated
%% axes.

%% Two-dimensional spherical wave centered at x(3),x(4) with amplitude x(1) and wavelength x(2)

F = exp( -100 ./ ( x(1)^2 - (xdata(:,:,1) - x(3)).^2 - (xdata(:,:,2) - x(2)).^2) );

[nx,ny,nz] = size(xdata);

ci = [x(2), x(3), x(1)];     % center and radius of circle ([c_row, c_col, r])
[xx,yy] = ndgrid((1:nx)-ci(1),(1:ny)-ci(2));
cm = uint8((xx.^2 + yy.^2) < ci(3)^2);
cm = double(cm);

F = F .* cm;

% figure;
% imagesc(F)
% x = [1, 1, 5, 1, 5, 0, 0]