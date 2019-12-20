function F = onedgauss(x,xdata)
%% Fitting function for a one-dimensional Gaussian


%% One-dimensional Gaussian
F= x(1)*exp(-((xdata-x(2)).^2/(2*x(3)^2)));

% figure;
% imagesc(F)
% x = [1, 1, 5, 1, 5, 0, 0]