function F = twogaussians(x,xdata)
%% Fitting function for a one-dimensional Gaussian


%% log-normal distribution
F= x(1) * exp(-((log(xdata)-x(2)).^2/(2*x(3)^2))) + x(4) * exp(-((log(xdata)-x(5)).^2/(2*x(6)^2)));
% figure;
% imagesc(F)
% x = [1, 1, 5, 1, 5, 0, 0]