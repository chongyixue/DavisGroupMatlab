function F = twodsphwave(x,xdata)
%% Fitting function for a two-dimensional Gaussian with possibly rotated
%% axes.

%% Two-dimensional spherical wave centered at x(3),x(4) with amplitude x(1) and wavelength x(2)

F = x(1) * cos(2*pi / (x(2)) .* (( xdata(:,:,1) - x(3) ).^2 + ( xdata(:,:,2) - x(4)).^2).^0.5 ) ./ ( (( xdata(:,:,1) - x(3) ).^2 + ( xdata(:,:,2) - x(4)).^2).^0.5 );

% figure;
% imagesc(F)
% x = [1, 1, 5, 1, 5, 0, 0]