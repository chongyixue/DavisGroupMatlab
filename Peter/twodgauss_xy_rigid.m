function F = twodgauss_xy_rigid(x,xdata)
%% Fitting function for a two-dimensional Gaussian with possibly rotated
%% axes.


%% Two-dimensional Gaussian
F= x(1)*exp(-((xdata(:,:,1)-x(2)).^2/(2*x(3)^2)+(xdata(:,:,2)-x(4)).^2/(2*x(5)^2)))+x(6);

% F= x(1)*exp(-((xdata(:,:,1)-x(2)).^2/(2*x(3)^2)+(xdata(:,:,2)-x(4)).^2/(2*x(5)^2)))+x(6) + ...
%     x(7)*(xdata(:,:,1)-x(8)) + x(9)*(xdata(:,:,1)-x(10));

% figure;
% imagesc(F)
% x = [1, 1, 5, 1, 5, 0, 0]