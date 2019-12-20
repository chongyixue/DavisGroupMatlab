function F = oneD_gauss(x,xdata)
%% Fitting function for a two-dimensional Gaussian with possibly rotated
%% axes.


%% Two 1D-dimensional Gaussians
F= x(1)*exp(-((xdata-x(2)).^2/(2*x(3)^2)));       

% figure;
% imagesc(F)
% x = [1, 1, 5, 1, 5, 0, 0]