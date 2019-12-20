function F = two_1D_gauss(x,xdata)
%% Fitting function for a two-dimensional Gaussian with possibly rotated
%% axes.


%% Two 1D-dimensional Gaussians
F= x(1)*exp(-((xdata-x(2)).^2/(2*x(3)^2))) + x(4)*exp(-((xdata-x(5)).^2/(2*x(6)^2)));       

% figure;
% imagesc(F)
% x = [1, 1, 5, 1, 5, 0, 0]