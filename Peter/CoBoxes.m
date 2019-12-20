function F = CoBoxes(x,xdata)
%% Fitting function for a two-dimensional Gaussian with possibly rotated
%% axes.

%% Rotate by angle x(7)
xdatarot(:,:,1)=xdata(:,:,1)*cos(x(6))-xdata(:,:,2)*sin(x(6));
ydatarot(:,:,1)=xdata(:,:,1)*sin(x(6))+xdata(:,:,2)*cos(x(6));
x0rot=x(2)*cos(x(6))-x(4)*sin(x(6));
y0rot=x(2)*sin(x(6))+x(4)*cos(x(6));

%% Two-dimensional Gaussian
F= x(1)*exp(-((xdatarot(:,:,1)-x0rot).^2/(2*x(3)^2)+(ydatarot(:,:,1)-y0rot).^2/(2*5*x(3)^2)))+x(5);

% figure;
% imagesc(F)