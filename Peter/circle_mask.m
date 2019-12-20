function [mask ] = circle_mask( N, x, y, r )
%create a circle mask

[X,Y] = meshgrid(1:N,1:N);

mask = (((X-x).^2+(Y-y).^2)<r^2);
figure(20), imagesc(mask);

end

