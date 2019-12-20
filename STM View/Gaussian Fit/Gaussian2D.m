function z = Gaussian2D(x,y,sigma_x,sigma_y,theta,x0,A)
%x,y meshgrid points
a = cos(theta)^2/2/sigma_x^2 + sin(theta)^2/2/sigma_y^2;
b = -sin(2*theta)/4/sigma_x^2 + sin(2*theta)/4/sigma_y^2;
c = sin(theta)^2/2/sigma_x^2 + cos(theta)^2/2/sigma_y^2;

z = zeros(length(x'),length(y'));
[X Y] = meshgrid(x,y);

z = A*exp(-(a*(X-x0(1)).^2 + 2*b*(X-x0(1)).*(Y-x0(2)) + c*(Y-x0(2)).^2));
%img_plot2(z);
%figure; pcolor(x,y,z); shading flat;
%figure; imagesc(x,y,z); shading flat;
%set(gca,'YDir','normal'); axis equal
end