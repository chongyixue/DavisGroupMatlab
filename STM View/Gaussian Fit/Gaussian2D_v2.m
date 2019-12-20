function z = Gaussian2D_v2(X,Y,sigma,x0,A)
%X,Y meshgrid points
%a = cos(theta)^2/2/sigma_x^2 + sin(theta)^2/2/sigma_y^2;
%b = -sin(2*theta)/4/sigma_x^2 + sin(2*theta)/4/sigma_y^2;
%c = sin(theta)^2/2/sigma_x^2 + cos(theta)^2/2/sigma_y^2;

z = zeros(length(X),length(Y));


%z = A*exp(-(a*(X-x0(1)).^2 + 2*b*(X-x0(1)).*(Y-x0(2)) + c*(Y-x0(2)).^2));
z = A*exp(-((X-x0(1)).^2 + (Y-x0(2)).^2)/(2*sigma));
%img_plot2(z);
end