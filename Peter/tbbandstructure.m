function F = tbbandstructure(x,xdata)
%% Fitting function for a two-dimensional Gaussian with possibly rotated
%% axes.

% F = x(1) +  ( xdata(:,:,1).^2 )/x(2) + ( xdata(:,:,2).^2 )/x(3);

F = x(1) * sqrt( (1 + cos(xdata(:,:,1)*x(2)+xdata(:,:,2)*x(3)) + ...
    cos(xdata(:,:,1)*x(4)+xdata(:,:,2)*x(5)) ).^2 + (sin(xdata(:,:,1)*x(2)+xdata(:,:,2)*x(3)) +...
    sin(xdata(:,:,1)*x(4)+xdata(:,:,2)*x(5)) ).^2 );
    

% F = x(1) +  ( cos (xdata(:,:,1)*x(4) ) )/x(2) + ( cos (xdata(:,:,2)*x(5) ) )/x(3);


% figure;
% imagesc(F)
% x = [1, 1, 5, 1, 5, 0, 0]