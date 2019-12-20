function z = Gaussian(x,y,std,x0,a)
%x,y meshgrid points
z = zeros(length(x'),length(y'));

for i=1:size(x')
    for j = 1:size(y')
        z(i,j) = a*(exp(-0.5*(x(i)-x0(1)).^2/(std^2)-0.5*(y(j)-x0(2)).^2/(std^2)));
    end
end

end