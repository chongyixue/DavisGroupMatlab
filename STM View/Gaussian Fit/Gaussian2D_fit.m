function param = Gaussian2D_fit(img,x,y,init_param)

% param(1) = A
% param(2) = x0
% param(3) = y0
% param(4) = sigma_x
% param(5) = sigma_y
% param(6) = theta (in radians)
[nr nc] = size(img);
%x = 1:nr; y = 1:nc;
[X Y] = meshgrid(x,y);
options = optimset('Display','off','TolFun',0.000001,'LargeScale','off');
param = fminunc(@fit_func,init_param,options,img,X,Y);
end
function z = fit_func(p,m,X,Y)
A = p(1);
x0 = p(2);
y0 = p(3);
sigma_x = p(4);
sigma_y = p(5);
theta = p(6);

a = cos(theta)^2/2/sigma_x^2 + sin(theta)^2/2/sigma_y^2;
b = -sin(2*theta)/4/sigma_x^2 + sin(2*theta)/4/sigma_y^2;
c = sin(theta)^2/2/sigma_x^2 + cos(theta)^2/2/sigma_y^2;

Z = A*exp(-(a*(X-x0).^2 + 2*b*(X-x0).*(Y-y0) + c*(Y-y0).^2)) - m;

z = sum(sum(Z.^2));
end