function F = lognormal(x,xdata)
%% Fitting function for a one-dimensional Gaussian


%% log-normal distribution
% F= (xdata*x(2)*sqrt(2*pi)).^(-1) .* exp(-((log(xdata)-x(1)).^2/(2*x(2)^2)));
F = lognpdf(xdata, x(1), x(2));
% figure;
% imagesc(F)
% x = [1, 1, 5, 1, 5, 0, 0]