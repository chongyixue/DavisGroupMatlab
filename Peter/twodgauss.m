function F = twodgauss(x,xdata)
%% Fitting function for a two-dimensional Gaussian with possibly rotated
%% axes.

%% Rotate by angle x(7)
xdatarot(:,:,1)=xdata(:,:,1)*cos(x(7))-xdata(:,:,2)*sin(x(7));
ydatarot(:,:,1)=xdata(:,:,1)*sin(x(7))+xdata(:,:,2)*cos(x(7));
x0rot=x(2)*cos(x(7))-x(4)*sin(x(7));
y0rot=x(2)*sin(x(7))+x(4)*cos(x(7));

%% Two-dimensional Gaussian
F= x(1)*exp(-((xdatarot(:,:,1)-x0rot).^2/(2*x(3)^2)+(ydatarot(:,:,1)-y0rot).^2/(2*x(5)^2)))+x(6);

% figure;
% imagesc(F)
% x = [1, 1, 5, 1, 5, 0, 0]